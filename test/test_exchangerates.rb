require 'Blockchain'
require_relative '../lib/blockchain/exchangerates'
require 'test/unit'

class TestExchangeRates < Test::Unit::TestCase

    def test_get_ticker_not_nil
        assert_not_nil Blockchain::ExchangeRateExplorer.new.get_ticker
    end

    def test_to_btc_invalid_ccy_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::ExchangeRateExplorer.new.to_btc('mau', 300) end
    end

    def test_to_btc_invalid_value_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::ExchangeRateExplorer.new.to_btc('USD', 'aaa') end
    end

    def test_to_btc_valid_args_no_exception
        assert_nothing_raised do Blockchain::ExchangeRateExplorer.new.to_btc('USD', 500) end
    end

    def test_from_btc_invalid_value_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::ExchangeRateExplorer.new.from_btc('GBP', 'cook') end
    end

    def test_from_btc_valid_args_no_exception
        assert_nothing_raised do Blockchain::ExchangeRateExplorer.new.from_btc('GBP', 100000000) end
    end

end