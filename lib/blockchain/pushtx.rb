require 'json'
require_relative 'client'

module Blockchain

    class PushTx

        attr_reader :client

        def initialize(base_url = nil, api_code = nil)
            @client = Client.new(base_url, api_code)
        end

        def pushtx(tx)
            params = { 'tx' => tx }
            @client.call_api('pushtx', method: 'post', data: params)
        end
    end

    private
    def self.proxy(method_name, api_code, tx)
        warn "[DEPRECATED] avoid use of static methods, use an instance of PushTx class instead."
        PushTx.new(nil, api_code).send(method_name, tx)
    end

	def self.pushtx(tx, api_code = nil)
        self.proxy(__method__, api_code, tx)
	end
end