require 'json'

require_relative 'util'

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

    def self.receive(xpub, callback, api_key)
      params = { 'xpub' => xpub, 'callback' => callback, 'key' => api_key }
      resp = Blockchain::call_api('v2/receive', method: 'get', data: params, base_url: 'https://api.blockchain.info/')
      json_resp = JSON.parse(resp)
      receive_response = ReceiveResponse.new(json_resp['address'],
                          json_resp['index'],
                          json_resp['callback'])
      receive_response
    end

    def self.callback_log(callback, api_key = nil)
      params = {'callback' => callback }
      params['key'] = api_key unless api_key.nil?
      resp = Blockchain::call_api('v2/receive/callback_log', method: 'get', data: params, base_url: 'https://api.blockchain.info/')
      json_resp = JSON.parse(resp)
      receive_response = json_resp.map do |entry|
        LogEntry.new(entry['callback'],
              entry['called_at'],
              entry['raw_response'],
              entry['response_code'])
      end
      receive_response
    end
  end


end