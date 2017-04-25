require 'json'
require_relative 'client'

module Blockchain

    class StatisticsExplorer

        attr_reader :client

        def initialize(base_url = nil, api_code = nil)
            @client = Client.new(base_url, api_code)
        end

        def proxy(method_name, *args)
            warn "[DEPRECATED] avoid use of static methods, use an instance of StatisticsExplorer class instead."
            send(method_name, *args)
        end

        def get_statistics()
            params = { 'format' => 'json' }
            resource = 'stats'
            response = @client.call_api(resource, method: 'get', data: params)
            return StatisticsResponse.new(JSON.parse(response))
        end

        def get_chart(chart_type, timespan = nil, rolling_average = nil)
            params = { 'format' => 'json' }
            if !timespan.nil? then params['timespan'] = timespan end
            if !rolling_average.nil? then params['rollingAverage'] = rolling_average end
            resource = 'charts/' + chart_type
            response = @client.call_api(resource, method: 'get', data: params)
            return ChartResponse.new(JSON.parse(response))
        end

        def get_pools(timespan = 4)
            if timespan < 1 || timespan > 10
                raise ArgumentError, 'timespan must be between 1 and 10'
            end
            params = { 'format' => 'json', 'timespan' => timespan.to_s + 'days' }
            resource = 'pools'
            response = @client.call_api(resource, method: 'get', data: params)
            return JSON.parse(response)
        end
    end

	def self.get(api_code = nil)
        Blockchain::StatisticsExplorer.new(nil, api_code).proxy('get_statistics')
	end

	class StatisticsResponse
        attr_reader :trade_volume_btc
        attr_reader :miners_revenue_usd
        attr_reader :btc_mined
        attr_reader :trade_volume_usd
        attr_reader :difficulty
        attr_reader :minutes_between_blocks
        attr_reader :number_of_transactions
        attr_reader :hash_rate
        attr_reader :timestamp
        attr_reader :mined_blocks
        attr_reader :blocks_size
        attr_reader :total_fees_btc
        attr_reader :total_btc_sent
        attr_reader :estimated_btc_sent
        attr_reader :total_btc
        attr_reader :total_blocks
        attr_reader :next_retarget
        attr_reader :estimated_transaction_volume_usd
        attr_reader :miners_revenue_btc
        attr_reader :market_price_usd

		def initialize(s)
			@trade_volume_btc = s['trade_volume_btc']
			@miners_revenue_usd = s['miners_revenue_usd']
			@btc_mined = s['n_btc_mined']
			@trade_volume_usd = s['trade_volume_usd']
			@difficulty = s['difficulty']
			@minutes_between_blocks = s['minutes_between_blocks']
			@number_of_transactions = s['n_tx']
			@hash_rate = s['hash_rate']
			@timestamp = s['timestamp']
			@mined_blocks = s['n_blocks_mined']
			@blocks_size = s['blocks_size']
			@total_fees_btc = s['total_fees_btc']
			@total_btc_sent = s['total_btc_sent']
			@estimated_btc_sent = s['estimated_btc_sent']
			@total_btc = s['totalbc']
			@total_blocks = s['n_blocks_total']
			@next_retarget = s['nextretarget']
			@estimated_transaction_volume_usd = s['estimated_transaction_volume_usd']
			@miners_revenue_btc = s['miners_revenue_btc']
			@market_price_usd = s['market_price_usd']
		end
	end

    class ChartResponse
        attr_reader :chart_name
        attr_reader :unit
        attr_reader :timespan
        attr_reader :description
        attr_reader :values

        def initialize(cr)
            @chart_name = cr['name']
            @unit = cr['unit']
            @timespan = cr['period']
            @description = cr['description']
            @values = cr['values'].map{ |value| ChartValue.new(value) }
        end
    end

    class ChartValue
        attr_reader :x
        attr_reader :y

        def initialize(cv)
            @x = cv['x']
            @y = cv['y']
        end
    end
end