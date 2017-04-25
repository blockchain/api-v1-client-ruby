require 'json'
require_relative 'client'

module Blockchain

    class PushTx

        attr_reader :client

        def initialize(base_url = nil, api_code = nil)
            @client = Client.new(base_url, api_code)
        end

        def proxy(method_name, tx)
            warn "[DEPRECATED] avoid use of static methods, use an instance of PushTx class instead."
            send(method_name, tx)
        end

        def pushtx(tx)
            params = { 'tx' => tx }
            @client.call_api('pushtx', method: 'post', data: params)
        end
    end

	def self.pushtx(tx, api_code = nil)
        Blockchain::PushTx.new(nil, api_code).proxy(__method__, tx)
	end
end