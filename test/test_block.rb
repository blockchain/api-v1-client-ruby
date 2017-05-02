require 'blockchain'
require_relative '../lib/blockchain/blockexplorer'
require 'test/unit'

class TestBlockExplorer < Test::Unit::TestCase

    def test_get_block_bad_hash_api_exception
        assert_raise( Blockchain::Client::APIException ) { Blockchain::BlockExplorer.new.get_block_by_hash("a") }
    end

    def test_get_block_correct_hash_no_exception
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_block_by_hash("0000000000000000019336c7ada4df81cfa3fb22e1851b3964cf65e3da1afe27") end
    end

    def test_get_tx_bad_has_api_exception
        assert_raise( Blockchain::Client::APIException ) { Blockchain::BlockExplorer.new.get_tx_by_hash("a") }
    end

    def test_get_tx_correct_hash_no_exception
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_tx_by_hash("4ff162eceb4392a38f269aab1ee1df567ae06875042b3ab6b53bd334c2e9e888") end
    end

    def test_get_block_height_bad_argument_exception
        assert_raise do Blockchain::BlockExplorer.new.get_block_height(-1) end
    end

    def test_get_block_height_correct_argument_no_exception
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_block_height(1000) end
    end

    def test_get_address_by_hash160_bad_hash_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::BlockExplorer.new.get_address_by_hash160("buns") end
    end

    def test_get_address_by_hash160_correct_hash_no_exception
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_address_by_hash160("1d6fdd6a2002594cfd6aad36ba635a303a23d795") end
    end

    def test_get_address_base58_bad_hash_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::BlockExplorer.new.get_address_by_base58("buns") end
    end

    def test_get_address_base58_correct_hash_no_exception
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_address_by_base58("13gec5DMEG3eW4CcEqLB2fBLPwZUwJqeC9") end
    end

    def test_get_xpub_bad_xpub_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::BlockExplorer.new.get_xpub('buns') end
    end

    def test_get_xpub_correct_xpub_no_exception
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_xpub("xpub6CmZamQcHw2TPtbGmJNEvRgfhLwitarvzFn3fBYEEkFTqztus7W7CNbf48Kxuj1bRRBmZPzQocB6qar9ay6buVkQk73ftKE1z4tt9cPHWRn") end
    end

    def test_get_xpub_correct_xpub_not_nil
        assert_not_nil Blockchain::BlockExplorer.new.get_xpub("xpub6CmZamQcHw2TPtbGmJNEvRgfhLwitarvzFn3fBYEEkFTqztus7W7CNbf48Kxuj1bRRBmZPzQocB6qar9ay6buVkQk73ftKE1z4tt9cPHWRn").address
    end

    def test_get_multi_address_bad_address_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::BlockExplorer.new.get_multi_address(['buns']) end
    end

    def test_get_multi_address_correct_address_no_excpetion
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_multi_address(['13gec5DMEG3eW4CcEqLB2fBLPwZUwJqeC9',
                                                                'xpub6CmZamQcHw2TPtbGmJNEvRgfhLwitarvzFn3fBYEEkFTqztus7W7CNbf48Kxuj1bRRBmZPzQocB6qar9ay6buVkQk73ftKE1z4tt9cPHWRn']) end
    end

    def test_get_unspent_outputs_bad_address_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::BlockExplorer.new.get_unspent_outputs(['buns']) end
    end

    def test_get_unspent_outputs_correct_address_no_excpetion
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_unspent_outputs(['13gec5DMEG3eW4CcEqLB2fBLPwZUwJqeC9',
                                                                'xpub6CmZamQcHw2TPtbGmJNEvRgfhLwitarvzFn3fBYEEkFTqztus7W7CNbf48Kxuj1bRRBmZPzQocB6qar9ay6buVkQk73ftKE1z4tt9cPHWRn']) end
    end

    def test_get_latest_block_not_nil
        assert_not_nil Blockchain::BlockExplorer.new.get_latest_block
    end

    def test_get_unconfirmed_tx_not_nil
        assert_not_nil Blockchain::BlockExplorer.new.get_unconfirmed_tx
    end

    def test_get_blocks_bad_time_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::BlockExplorer.new.get_blocks(time = -1) end
    end

    def test_get_blocks_bad_poolname_api_exception
        assert_raise Blockchain::Client::APIException do Blockchain::BlockExplorer.new.get_blocks(pool_name = 'wombat') end
    end

    def test_get_blocks_correct_params_no_exception
        assert_nothing_raised do Blockchain::BlockExplorer.new.get_blocks(1493052735, 'BTCC Pool') end
    end

end