require 'json'
require_relative 'client'

module Blockchain

    MAX_TRANSACTIONS_PER_REQUEST = 50
    MAX_TRANSACTIONS_PER_MULTI_REQUEST = 100
    DEFAULT_UNSPENT_TRANSACTIONS_PER_REQUEST = 250

    class BlockExplorer

        attr_reader :client

        def initialize(base_url = nil, api_code = nil)
            @client = Client.new(base_url, api_code)
        end

        def proxy(method_name, *args)
            warn "[DEPRECATED] avoid use of static methods, use an instance of BlockExplorer class instead."
            send(method_name, *args)
        end

        # Deprecated. Please use get_block_by_hash whenever possible.
        def get_block_by_index(index)
            warn "[DEPRECATED] `get_block_by_index` is deprecated. Please use `get_block_by_hash` whenever possible."
            return get_block(index.to_s)
        end

        def get_block_by_hash(block_hash)
            return get_block(block_hash)
        end

        # Deprecated. Please use get_tx_by_hash whenever possible.
        def get_tx_by_index(tx_index)
            warn "[DEPRECATED] `get_tx_by_index` is deprecated. Please use `get_tx_by_hash` whenever possible."
            return get_tx(tx_index.to_s)
        end

        def get_tx_by_hash(tx_hash)
            return get_tx(tx_hash)
        end

        def get_block_height(height)
            params = { 'format' => 'json' }
            resource = "block-height/#{height}"
            response = @client.call_api(resource, method: 'get', data: params)
            return JSON.parse(response)['blocks'].map{ |b| Block.new(b) }
        end

        def get_address_by_hash160(address, limit = MAX_TRANSACTIONS_PER_REQUEST,
                                    offset = 0, filter = FilterType::REMOVE_UNSPENDABLE)
            return get_address(address, limit, offset, filter)
        end

        def get_address_by_base58(address, limit = MAX_TRANSACTIONS_PER_REQUEST,
                                    offset = 0, filter = FilterType::REMOVE_UNSPENDABLE)
            return get_address(address, limit, offset, filter)
        end

        def get_xpub(xpub, limit = MAX_TRANSACTIONS_PER_MULTI_REQUEST,
                    offset = 0, filter = FilterType::REMOVE_UNSPENDABLE)
            params = { 'active' => xpub, 'format' => 'json', 'limit' => limit, 'offset' => offset, 'filter' => filter }
            resource = 'multiaddr'
            response = @client.call_api(resource, method: 'get', data: params)
            return Xpub.new(JSON.parse(response))
        end

        def get_multi_address(address_array, limit = MAX_TRANSACTIONS_PER_MULTI_REQUEST,
                                offset = 0, filter = FilterType::REMOVE_UNSPENDABLE)
            params = { 'active' => address_array.join("|"), 'format' => 'json', 'limit' => limit, 'offset' => offset, 'filter' => filter }
            resource = 'multiaddr'
            response = @client.call_api(resource, method: 'get', data: params)
            return MultiAddress.new(JSON.parse(response))
        end

        def get_unspent_outputs(address_array,
                                limit = DEFAULT_UNSPENT_TRANSACTIONS_PER_REQUEST,
                                confirmations = 0)
            params = { 'active' => address_array.join("|"), 'limit' => limit, 'confirmations' => confirmations }
            resource = 'unspent'
            response = @client.call_api(resource, method: 'get', data: params)
            return JSON.parse(response)['unspent_outputs'].map{ |o| UnspentOutput.new(o) }
        end

        def get_latest_block()
            resource = 'latestblock'
            response = @client.call_api(resource, method: 'get')
            return LatestBlock.new(JSON.parse(response))
        end

        def get_unconfirmed_tx()
            params = { 'format' => 'json' }
            resource = 'unconfirmed-transactions'
            response = @client.call_api(resource, method: 'get', data: params)
            return JSON.parse(response)['txs'].map{ |t| Transaction.new(t) }
        end

        def get_blocks(time = nil, pool_name = nil)
            params = { 'format' => 'json' }
            resource = "blocks/"
            if !time.nil?
                resource += time.to_s
            elsif !pool_name.nil?
                resource += pool_name
            end
            response = @client.call_api(resource, method: 'get', data: params)
            return JSON.parse(response)['blocks'].map{ |b| SimpleBlock.new(b) }
        end

        private
        def get_block(hash_or_index)
            resource = 'rawblock/' + hash_or_index
            response = @client.call_api(resource, method: 'get')
            return Block.new(JSON.parse(response))
        end

        private
        def get_tx(hash_or_index)
            resource = 'rawtx/' + hash_or_index
            response = @client.call_api(resource, method: 'get')
            return Transaction.new(JSON.parse(response))
        end

        private
        def get_address(address, limit = MAX_TRANSACTIONS_PER_REQUEST,
                        offset = 0, filter = FilterType::REMOVE_UNSPENDABLE)
            params = { 'format' => 'json', 'limit' => limit, 'offset' => offset, 'filter' => filter }
            resource = 'rawaddr/' + address
            response = @client.call_api(resource, method: 'get', data: params)
            return Address.new(JSON.parse(response))
        end
    end

    def self.get_block(hash_or_index, api_code = nil)
        Blockchain::BlockExplorer.new(nil, api_code).proxy(__method__, hash_or_index)
    end

    def self.get_tx(hash_or_index, api_code = nil)
        Blockchain::BlockExplorer.new(nil, api_code).proxy(__method__, hash_or_index)
    end

	def self.get_block_height(height, api_code = nil)
		Blockchain::BlockExplorer.new(nil, api_code).proxy(__method__, height)
	end

    def self.get_address(address, api_code = nil,
                        limit = MAX_TRANSACTIONS_PER_REQUEST, offset = 0,
                        filter = FilterType::REMOVE_UNSPENDABLE)
        Blockchain::BlockExplorer.new(nil, api_code).proxy(__method__, address, limit, offset, filter)
    end

	def self.get_unspent_outputs(address_array, api_code = nil,
                                limit = DEFAULT_UNSPENT_TRANSACTIONS_PER_REQUEST, confirmations = 0)
		Blockchain::BlockExplorer.new(nil, api_code).proxy(__method__, limit, confirmations)
	end

	def self.get_unconfirmed_tx(api_code = nil)
		Blockchain::BlockExplorer.new(nil, api_code).proxy(__method__)
	end

	def self.get_blocks(api_code = nil, time: nil, pool_name: nil)
		Blockchain::BlockExplorer.new(nil, api_code).proxy(__method__, time, pool_name)
	end

	def self.get_latest_block(api_code = nil)
		Blockchain::BlockExplorer.new(nil, api_code).proxy(__method__)
	end

	class SimpleBlock
		attr_reader :height
		attr_reader :hash
		attr_reader :time
		attr_reader :main_chain

		def initialize(b)
			@height = b['height']
			@hash = b['hash']
			@time = b['time']
			@main_chain = b['main_chain']
		end
	end

	class LatestBlock
		attr_reader :hash
		attr_reader :time
		attr_reader :block_index
		attr_reader :height
		attr_reader :tx_indexes

		def initialize(b)
			@hash = b['hash']
			@time = b['time']
			@block_index = b['block_index']
			@height = b['height']
			@tx_indexes = b['txIndexes']
		end
	end

	class UnspentOutput
		attr_reader :tx_hash
		attr_reader :tx_index
		attr_reader :tx_output_n
		attr_reader :script
		attr_reader :value
		attr_reader :value_hex
		attr_reader :confirmations

		def initialize(o)
			@tx_hash = o['tx_hash']
			@tx_index = o['tx_index']
			@tx_output_n = o['tx_output_n']
			@script = o['script']
			@value = o['value']
			@value_hex = o['value_hex']
			@confirmations = o['confirmations']
		end
	end

	class Address
		attr_reader :hash160
		attr_reader :address
		attr_reader :n_tx
		attr_reader :total_received
		attr_reader :total_sent
		attr_reader :final_balance
		attr_reader :transactions

		def initialize(a)
			@hash160 = a['hash160'] == nil ? nil : a['hash160']
			@address = a['address']
			@n_tx = a['n_tx']
			@total_received = a['total_received']
			@total_sent = a['total_sent']
			@final_balance = a['final_balance']
			@transactions = a['txs'] == nil ? nil : a['txs'].map{ |tx| Transaction.new(tx) }
		end
	end

    class MultiAddress
        attr_reader :addresses
        attr_reader :transactions

        def initialize(ma)
            @addresses = ma['addresses'].map{ |a| Address.new(a) }
            @transactions = ma['txs'].map{ |tx| Transaction.new(tx) }
        end
    end

    class Xpub < Address
        attr_reader :change_index
        attr_reader :account_index
        attr_reader :gap_limit

        def initialize(x)
            addr = x['addresses'][0]
            @change_index = addr['change_index']
            @account_index = addr['account_index']
            @gap_limit = addr['gap_limit']
            @hash160 = addr['hash160'] == nil ? nil : addr['hash160']
            @address = addr['address']
			@n_tx = addr['n_tx']
			@total_received = addr['total_received']
			@total_sent = addr['total_sent']
			@final_balance = addr['final_balance']
			@transactions = addr['txs'] == nil ? nil : addr['txs'].map{ |tx| Transaction.new(tx) }
        end
    end

	class Input
		attr_reader :n
		attr_reader :value
		attr_reader :address
		attr_reader :tx_index
		attr_reader :type
		attr_reader :script
		attr_reader :script_sig
		attr_reader :sequence

		def initialize(i)
			obj = i['prev_out']
			if !obj.nil?
			# regular TX
				@n = obj['n']
				@value = obj['value']
				@address = obj['addr']
				@tx_index = obj['tx_index']
				@type = obj['type']
				@script = obj['script']
				@script_sig = i['script']
				@sequence = i['sequence']
			else
			# coinbase TX
				@script_sig = i['script']
				@sequence = i['sequence']
			end
		end
	end

	class Output
		attr_reader :n
		attr_reader :value
		attr_reader :address
		attr_reader :tx_index
		attr_reader :script
		attr_reader :spent

		def initialize(o)
			@n = o['n']
			@value = o['value']
			@address = o['addr']
			@tx_index = o['tx_index']
			@script = o['script']
			@spent = o['spent']
		end
	end

	class Transaction
		attr_reader :double_spend
		attr_reader :block_height
		attr_reader :time
		attr_reader :relayed_by
		attr_reader :hash
		attr_reader :tx_index
		attr_reader :version
		attr_reader :size
		attr_reader :inputs
		attr_reader :outputs

		def initialize(t)
			@double_spend = t.fetch('double_spend', false)
			@block_height = t.fetch('block_height', false)
			@time = t['time']
			@relayed_by = t['relayed_by']
			@hash = t['hash']
			@tx_index = t['tx_index']
			@version = t['ver']
			@size = t['size']
			@inputs = t['inputs'].map{ |i| Input.new(i) }
			@outputs = t['out'].map{ |o| Output.new(o) }

			if @block_height.nil?
				@block_height = -1
			end
		end

		def adjust_block_height(h)
			@block_height = h
		end
	end


	class Block
		attr_reader :hash
		attr_reader :version
		attr_reader :previous_block
		attr_reader :merkle_root
		attr_reader :time
		attr_reader :bits
		attr_reader :fee
		attr_reader :nonce
		attr_reader :n_tx
		attr_reader :size
		attr_reader :block_index
		attr_reader :main_chain
		attr_reader :height
		attr_reader :received_time
		attr_reader :relayed_by
		attr_reader :transactions

		def initialize(b)
			@hash = b['hash']
			@version = b['ver']
			@previous_block = b['prev_block']
			@merkle_root = b['mrkl_root']
			@time = b['time']
			@bits = b['bits']
			@fee = b['fee']
			@nonce = b['nonce']
			@n_tx = b['n_tx']
			@size = b['size']
			@block_index = b['block_index']
			@main_chain = b['main_chain']
			@height = b['height']
			@received_time = b['received_time']
			@relayed_by = b['relayed_by']
			@transactions = b['tx'].map{ |tx| Transaction.new(tx) }
			@transactions.each do |tx|
				tx.adjust_block_height(@height)
			end

			if @received_time.nil?
				@received_time = @time
			end
		end
	end

    module FilterType
        ALL = 4
        CONFIRMED_ONLY = 5
        REMOVE_UNSPENDABLE = 6
    end
end