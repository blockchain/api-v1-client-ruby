require 'Blockchain'
require_relative '../lib/blockchain/pushtx'
require 'test/unit'

class TestPushTx < Test::Unit::TestCase

    def test_push_tx_nil_param_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::PushTx.new.pushtx(nil) end
    end

end