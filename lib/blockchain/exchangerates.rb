require 'json'
require_relative 'client'

module Blockchain

    class ExchangeRateExplorer

        attr_reader :client

        def initialize(base_url = nil, api_code = nil)
            @client = Client.new(base_url, api_code)
        end

        def proxy(method_name, *args)
            warn "[DEPRECATED] avoid use of static methods, use an instance of ExchangeRateExplorer class instead."
            send(method_name, *args)
        end

        def get_ticker()
            params = {}
            response = @client.call_api('ticker', data: params)
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

        def to_btc(ccy, value)
            params = { 'currency' => ccy, 'value' => value}
            return @client.call_api('tobtc', data: params).to_f
        end

        def from_btc(ccy = nil, satoshi_value)
            params = {'value' => satoshi_value}
            if !ccy.nil? then params['currency'] = ccy end
            return @client.call_api('frombtc', data: params).to_f
        end

    end

	def self.get_ticker(api_code = nil)
        Blockchain::ExchangeRateExplorer.new(nil, api_code).proxy(__method__)
	end

	def self.to_btc(ccy, value, api_code = nil)
        Blockchain::ExchangeRateExplorer.new(nil, api_code).proxy(__method__, ccy, value)
	end

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

end