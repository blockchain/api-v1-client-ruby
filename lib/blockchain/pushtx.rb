require 'json'
require_relative 'util'

module Blockchain

  def self.pushtx(tx, api_code = nil)
    params = { 'tx' => tx }
    
    if !api_code.nil?
      params['api_code'] = api_code
    end
    
    Blockchain::call_api('pushtx', method: 'post', data: params)
  end

end