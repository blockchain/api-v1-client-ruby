require 'blockchain'
require_relative '../lib/blockchain/wallet'
require_relative '../lib/blockchain/createwallet'
require 'test/unit'

# Local waller service must be running for carrying out these tests

class TestWallet < Test::Unit::TestCase

    def test_get_balance_not_nil
        assert_nothing_raised do Blockchain::Wallet.new('773d4edb-bffe-4790-8712-8d232ce04b0c', 'Password1!', 'http://localhost:3000/', 'Password2!').get_balance end
    end

    def test_list_addresses_not_nil
        assert_not_nil Blockchain::Wallet.new('773d4edb-bffe-4790-8712-8d232ce04b0c', 'Password1!', 'http://localhost:3000/', 'Password2!').list_addresses
    end

    def test_get_address_invalid_address_api_exception
        assert_raise Blockchain::Client::APIException do puts Blockchain::Wallet.new('773d4edb-bffe-4790-8712-8d232ce04b0c', 'Password1!', 'http://localhost:3000/', 'Password2!').get_address('booboo').address end
    end

    def test_get_address_valid_address_no_exception
        wallet = Blockchain::Wallet.new('773d4edb-bffe-4790-8712-8d232ce04b0c', 'Password1!', 'http://localhost:3000/', 'Password2!')
        addr = wallet.list_addresses[1]
        assert_nothing_raised Blockchain::Client::APIException do wallet.get_address(addr.address) end
    end

    def test_new_address_no_exception
        assert_nothing_raised do Blockchain::Wallet.new('773d4edb-bffe-4790-8712-8d232ce04b0c', 'Password1!', 'http://localhost:3000/', 'Password2!').new_address end
    end

    def test_archive_address_no_exception
        wallet = Blockchain::Wallet.new('773d4edb-bffe-4790-8712-8d232ce04b0c', 'Password1!', 'http://localhost:3000/', 'Password2!')
        addr = wallet.list_addresses[1]
        assert_nothing_raised do wallet.archive_address(addr.address) end
    end

    def test_unarchive_address_no_exception
        wallet = Blockchain::Wallet.new('773d4edb-bffe-4790-8712-8d232ce04b0c', 'Password1!', 'http://localhost:3000/', 'Password2!')
        addr = wallet.list_addresses[1]
        assert_nothing_raised do wallet.unarchive_address(addr.address) end
    end

end