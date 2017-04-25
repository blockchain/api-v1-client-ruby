require 'json'
require_relative 'client'

module Blockchain

    DEFAULT_WALLET_URL = 'http://127.0.0.1:3000/'

    class WalletCreator

        attr_reader :client

        def initialize(base_url = DEFAULT_WALLET_URL, api_code)
            @client = Client.new(base_url, api_code)
        end

        def create_wallet(password, priv: nil, label: nil, email: nil)
            params = { 'password' => password }

            if !priv.nil?
                params['priv'] = priv
            end
            if !label.nil?
                params['label'] = label
            end
            if !email.nil?
                params['email'] = email
            end

            response = @client.call_api('api/v2/create', method: 'post', data: params)
            json_response = JSON.parse(response)
            return CreateWalletResponse.new(json_response['guid'],
                                            json_response['address'],
                                            json_response['label'])
        end
    end

	def self.create_wallet(password, api_code, url, priv: nil, label: nil, email: nil)
        warn "[DEPRECATED] avoid use of static methods, use an instance of WalletCreator class instead."
        Blockchain::WalletCreator.new(url, api_code).create_wallet(password, priv, label, email)
	end

	class CreateWalletResponse
		attr_reader :identifier
		attr_reader :address
		attr_reader :label

		def initialize(identifier, address, label)
			@identifier = identifier
			@address = address
			@label = label
		end
	end

end