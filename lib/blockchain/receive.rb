require 'json'

require_relative 'client'

module Blockchain

	class ReceiveResponse
		attr_reader :fee_percent
		attr_reader :destination
		attr_reader :input_address
		attr_reader :callback_url

		def initialize(fee_percent, dest, input, callback)
			@fee_percent = fee_percent
			@destination = dest
			@input_address = input
			@callback_url = callback
		end
	end

	module V2

        class Receive

            attr_reader :client

            def initialize(base_url = nil)
                base_url = base_url.nil? ? 'https://api.blockchain.info/v2/' : base_url
                @client = Client.new(base_url)
            end

            def proxy(method_name, *args)
                warn "[DEPRECATED] avoid use of static methods, use an instance of Receive class instead."
                send(method_name, *args)
            end

            def receive(xpub, callback, api_key, gap_limit = nil)
                params = { 'xpub' => xpub, 'callback' => callback, 'key' => api_key }
                if !gap_limit.nil? then params['gap_limit'] = gap_limit end
                response = @client.call_api('receive', method: 'get', data: params)
                return ReceiveResponse.new(JSON.parse(response))
            end

            def callback_log(callback, api_key = nil)
                params = {'callback' => callback }
                params['key'] = api_key unless api_key.nil?
                response = @client.call_api('receive/callback_log', method: 'get', data: params)
                json_resp = JSON.parse(response)
                log_entries = json_resp.map do |entry|
                    LogEntry.new(JSON.parse(entry))
                end
                return log_entries
            end

            def check_gap(xpub, api_key = nil)
                params = {'xpub' => xpub}
                params['key'] = api_key unless api_key.nil?
                response = @client.call_api('receive/checkgap', method: 'get', data: params)
                return JSON.parse(response)
            end

        end

		def self.receive(xpub, callback, api_key)
            Blockchain::V2::Receive.new.proxy(__method__, xpub, callback, api_key)
		end

		def self.callback_log(callback, api_key = nil)
            Blockchain::V2::Receive.new.proxy(__method__, callback, api_key)
		end

        class ReceiveResponse
			attr_reader :address
			attr_reader :index
			attr_reader :callback_url

			def initialize(address, index, callback)
				@address = address
				@index = index
				@callback_url = callback
			end
		end

		class LogEntry
			attr_reader :callback_url
			attr_reader :called_at
			attr_reader :raw_response
			attr_reader :response_code

			def initialize(callback_url, called_at, raw_response, response_code)
				@callback_url = callback_url
				@called_at = called_at
				@raw_response = raw_response
				@response_code = response_code
			end
		end
	end


end