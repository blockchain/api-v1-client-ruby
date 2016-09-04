require 'json'
require_relative 'util'

module Blockchain
  
  class Currency
    attr_reader :last
    attr_reader :buy
    attr_reader :sell
    attr_reader :symbol
    attr_reader :p15min

    def initialize(last, buy, sell, symbol, p15min)
      @last = last
      @buy = buy
      @sell = sell
      @symbol = symbol
      @p15min = p15min
    end
  end

  def self.get_ticker(api_code = nil)
    params = {}
    if !api_code.nil? then params['api_code'] = api_code end
    response = Blockchain::call_api('ticker', data: params)
    json_response = JSON.parse(response)
    
    ticker = {}
    json_response.each do |key,value|
      json_ccy = json_response[key]
      ccy = Currency.new(json_ccy['last'],
                json_ccy['buy'],
                json_ccy['sell'],
                json_ccy['symbol'],
                json_ccy['15m'])
      ticker[key] = ccy
    end
    return ticker
  end

  def self.to_btc(ccy, value, api_code = nil)
    params = { 'currency' => ccy, 'value' => value}
    if !api_code.nil? then params['api_code'] = api_code end
    return Blockchain::call_api('tobtc', data: params).to_f
  end

end