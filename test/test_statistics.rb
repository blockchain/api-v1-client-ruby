require 'Blockchain'
require_relative '../lib/blockchain/statistics'
require 'test/unit'

class TestStatistics < Test::Unit::TestCase

    def test_get_stats_not_nil
        assert_not_nil Blockchain::StatisticsExplorer.new.get_statistics
    end

    def test_get_chart_wrong_name_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::StatisticsExplorer.new.get_chart('bomba') end
    end

    def test_get_chart_invalid_timespan_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::StatisticsExplorer.new.get_chart('transactions-per-second', 'dongledays') end
    end

    def test_get_chart_invalid_rolling_avg_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::StatisticsExplorer.new.get_chart('transactions-per-second', rolling_average = 'dongledays') end
    end

    def test_get_chart_valid_params_no_exception
        assert_nothing_raised do Blockchain::StatisticsExplorer.new.get_chart('transactions-per-second', '5weeks', '8hours') end
    end

    def test_get_pools_invalid_timespan_argument_error
        assert_raise ArgumentError do Blockchain::StatisticsExplorer.new.get_pools(11) end
    end

    def test_get_pools_valid_params_no_exception
        assert_nothing_raised do Blockchain::StatisticsExplorer.new.get_pools end
    end

end