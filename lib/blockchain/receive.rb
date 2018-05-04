require 'json'

require_relative 'client'

module Blockchain
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
        params['gap_limit'] = gap_limit unless gap_limit.nil?
        response = @client.call_api('receive', method: 'get', data: params)
        ReceiveResponse.new(JSON.parse(response))
      end

      def callback_log(callback, api_key = nil)
        params = { 'callback' => callback }
        params['key'] = api_key unless api_key.nil?
        response = @client.call_api('receive/callback_log', method: 'get', data: params)
        JSON.parse(response).map { |entry| LogEntry.new(entry) }
      end

      def check_gap(xpub, api_key = nil)
        params = { 'xpub' => xpub }
        params['key'] = api_key unless api_key.nil?
        response = @client.call_api('receive/checkgap', method: 'get', data: params)
        JSON.parse(response)
      end

    end

    def self.receive(xpub, callback, api_key)
      Blockchain::V2::Receive.new.proxy(__method__, xpub, callback, api_key)
    end

    def self.callback_log(callback, api_key = nil)
      Blockchain::V2::Receive.new.proxy(__method__, callback, api_key)
    end

    class ReceiveResponse
      # @return [String]
      attr_reader :address

      # @return [Integer]
      attr_reader :index

      # @return [String]
      attr_reader :callback_url

      def initialize(response)
        @address = response['address']
        @index = response['index']
        @callback_url = response['callback']
      end
    end

    class LogEntry
      # @return [String]
      attr_reader :callback_url

      # @return [Time]
      attr_reader :called_at

      # @return [String]
      attr_reader :raw_response

      # @return [Integer]
      attr_reader :response_code

      def initialize(response)
        @callback_url = response['callback']
        @called_at = Time.at(response['calledAt'] / 1000.0)
        @raw_response = response['rawResponse']
        @response_code = response['responseCode']
      end
    end
  end
end
