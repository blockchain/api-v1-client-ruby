# Block Explorer functionality

Initialize an instance of the `BlockExplorer` class:

```ruby
require 'Blockchain'

# create an instance pointing to https://blockchain.info/ with no api code
explorer = Blockchain::BlockExplorer.new

# create an instance potining to https://blockchain.info/ with an api code
explorer = Blockchain::BlockExplorer.new(api_code = 'your-api-code')

# create an instance pointing to an alternative base url with no api code
explorer = Blockchain::BlockExplorer.new('http://some-alternative-url')

# create an instance pointing to an alternative base url with an api code
explorer = Blockchain::BlockExplorer.new('http://some-alternative-url', 'your-api-code')
```

## Methods

### `get_block_by_index`

Get a single block based on a block index. Returns a `Block` object. (Deprecated)

##### Params:
* `int block_index`

##### Usage:
```ruby
explorer.get_block_by_index(1486749)
```

### `get_block_by_hash`

Get a single block based on a block hash. Returns a `Block` object.

##### Params:
* `str block_hash`

##### Usage:
```ruby
explorer.get_block_by_hash('000000000000000016f9a2c3e0f4c1245ff24856a79c34806969f5084f410680')
```

### `get_tx_by_index`

Get a single transaction based on a transaction index. Returns a `Transaction` object. (Deprecated)

##### Params:
* `int tx_index`

##### Usage:
```ruby
explorer.get_tx_by_index(243169766)
```

### `get_tx_by_hash`

Get a single transaction based on a transaction hash. Returns a `Transaction` object.

##### Params:
* `str tx_hash`

##### Usage:
```ruby
explorer.get_tx_by_hash('d4af240386cdacab4ca666d178afc88280b620ae308ae8d2585e9ab8fc664a94')
```

### `get_block_height`

Get an array of blocks at the specified height. Returns an array of `Block` objects.

##### Params:
* `int height`

##### Usage:
```ruby
explorer.get_block_height(2570)
```

---
### Get Address

The implementations of these methods are currently interchangeable, but this is liable to change in the future. All address methods accept the following optional parameters:

* `int limit` - the number of transactions to limit the response to (max. 50, default 50 for a single address, max. 100, default 100 for multiple addresses)
* `int offset` - skip the first n transactions (default 0). This can be used to get more than the maximum number of transactions
* `FilterType filter` - type of filter to use for the query (default FilterType::REMOVE_UNSPENDABLE)

### `get_address_by_hash160`

Get a single hash160 address and its transactions. Returns an `Address` object.

##### Params:
* `str address` - address in hash160 format

##### Usage:
```ruby
explorer.get_address_by_hash160('5ddda1c11ce7df6681cb064cf9aab5d6df44bb1b')
```

### `get_address_by_base58`

Get a single base58check address and its transactions. Returns an `Address` object.

##### Params:
* `str address` - address in base58check format

##### Usage:
```ruby
explorer.get_address_by_base58('19ZKM6JFvCiBQbqqHPzRDLGHpN6wkQnXDs')
```

### `get_xpub`

Get the xPub summary with its overall balanace and transactions. Returns a `Xpub` object.

##### Params:
* `str xpub` - xPub address

##### Usage:
```ruby
explorer.get_xpub('xpub6CmZamQcHw2TPtbGmJNEvRgfhLwitarvzFn3fBYEEkFTqztus7W7CNbf48Kxuj1bRRBmZPzQocB6qar9ay6buVkQk73ftKE1z4tt9cPHWRn')
```

### `get_multi_address`

Get data for multiple base58check and / or xpub addresses. Returns a `MultiAddress` object.

##### Params:
* `str[] address_array`

##### Usage:
```ruby
address_array = ['1C48NriBmPVvgCk1V5eNCS82zbSrKoPLbK', '1MyAwSkfdnTsV2uAsHiHMNcxqYhtWwNWSQ', '1Dn5EfV8bvfNu7HQ9iKr467nPFRiogKv9G']
explorer.get_multi_address(address_array)
```
---

### `get_unspent_outputs`

Get an array of unspent outputs for one or more base58check or hash160 addresses. Returns an array of `UnspentOutput` objects.

##### Params:
* `str[] address_array`
* `int limit` (optional) - the number of transactions to limit the response to (max. 1000, default 250)
* `int confirmations` (optional) - minimum number of confirmations to show (default 0)

##### Usage:
```ruby
explorer.get_unspent_outputs(['1HS9RLmKvJ7D1ZYgfPExJZQZA1DMU3DEVd'])
```

### `get_latest_block`
Get the latest block on the main chain. Returns a `LatestBlock` object.

##### Usage:
```ruby
explorer.get_latest_block()
```

### `get_unconfirmed_tx`
Get the last 10 unconfirmed transactions. Returns an array of `Transaction` objects.

##### Usage:
```ruby
explorer.get_unconfirmed_tx()
```

### `get_blocks`
Get a list of blocks for a specific day or mining pool. Returns an array of `SimpleBlock` objects.

##### Params:
* `int time` (optional) - unix time in ms
* `str pool_name` (optional) - pool name

Providing neither parameter will return all blocks mined today.

##### Usage:
```ruby
blocks = explorer.get_blocks(pool_name = 'Discus Fish')
```

Note regarding `Input` objects: if coinbase transaction, only `script` and `script_siq` will be populated.

## Response Object Properties

A description of the objects returned by the methods in this class

### SimpleBlock Object
* `height`
* `hash`
* `time`
* `main_chain`

### LatestBlock Object
* `hash`
* `time`
* `block_index`
* `height`
* `tx_indexes`

### UnspentOutput Object
* `tx_hash`
* `tx_index`
* `tx_output_n`
* `script`
* `value`
* `value_hex`
* `confirmations`

### Address Object
* `hash160`
* `address`
* `n_tx`
* `total_received`
* `total_sent`
* `final_balance`
* `transactions`

### MultiAddress Object
* `addresses`
* `transactions`

### Xpub Object
* `address`
* `n_tx`
* `total_received`
* `total_sent`
* `final_balance`
* `change_index`
* `account_index`
* `gap_limit`

### Input Object
* `n`
* `value`
* `address`
* `tx_index`
* `type`
* `script`
* `script_sig`
* `sequence`

### Output Object
* `n`
* `value`
* `address`
* `tx_index`
* `script`
* `spent`

### Transaction Object
* `double_spend`
* `block_height`
* `time`
* `relayed_by`
* `hash`
* `tx_index`
* `version`
* `size`
* `inputs`
* `outputs`

### Block Object
* `hash`
* `version`
* `previous_block`
* `merkle_root`
* `time`
* `bits`
* `fee`
* `nonce`
* `n_tx`
* `size`
* `block_index`
* `main_chain`
* `height`
* `received_time`
* `relayed_by`
* `transactions`

### FilterType Enum
* `ALL`
* `CONFIRMED_ONLY`
* `REMOVE_UNSPENDABLE`
