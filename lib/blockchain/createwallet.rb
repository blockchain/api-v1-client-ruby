require 'json'
require_relative 'util'

module Blockchain

  def self.create_wallet(password, api_code, url, priv: nil, label: nil, email: nil)

    params = { 'password' => password, 'api_code' => api_code }
    
    if !priv.nil?
      params['priv'] = priv
    end
    if !label.nil?
      params['label'] = label
    end
    if !email.nil?
      params['email'] = email
    end
    
    response = Blockchain::call_api('api/v2/create', method: 'post', data: params, base_url: url)
    json_response = JSON.parse(response)
    return CreateWalletResponse.new(json_response['guid'],
                    json_response['address'],
                    json_response['label'])
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