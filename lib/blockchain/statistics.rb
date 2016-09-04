require 'json'
require_relative 'util'

module Blockchain

  def self.get_statistics(api_code = nil)
    params = { 'format' => 'json' }
    if !api_code.nil? then params['api_code'] = api_code end
    response = Blockchain::call_api('stats', method: 'get', data: params)
    json_response = JSON.parse(response)
    return StatisticsResponse.new(json_response)
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
  
end