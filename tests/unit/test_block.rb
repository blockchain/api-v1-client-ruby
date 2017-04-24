require 'Blockchain'
require_relative '../../lib/blockchain/blockexplorer'
require_relative '../../lib/blockchain/client'
require 'test/unit'

class TestBlockExplorer < Test::Unit::TestCase

    def test_get_block_bad_hash_api_exception
        assert_raise( Blockchain::APIException ) { Blockchain::BlockExplorer.new.get_block_by_hash("a") }
    end

    def test_get_block_correct_hash_no_exception
        assert_nothing_raised do
            Blockchain::BlockExplorer.new.get_block_by_hash("0000000000000000019336c7ada4df81cfa3fb22e1851b3964cf65e3da1afe27")
        end
    end


end