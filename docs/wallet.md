# Wallet functionality

An instance of the `Wallet` class needs to be initialized before it can be used.

##### Constructor params:

* `str identifier`
* `str password`
* `str url` (optional, defaults to http://localhost:3000)
* `str second_password` (optional)
* `str api_code` (optional)

##### Usage:
```ruby
require 'Blockchain'

wallet = Blockchain::Wallet.new('ada4e4b6-3c9f-11e4-baad-164230d1df67', 'password123')
```

## Methods

### `send`
Send bitcoin from your wallet to a single address. Returns a `PaymentResponse` object.

##### Params:
* `str to` - receiving address
* `int amount` - amount to send (in satoshi)
* `str from_address` (optional, keyword) - specific address to send from
* `int fee` (optional, keyword) - transaction fee in satoshi. Must be greater than default

##### Usage:
```ruby
payment = wallet.send('1NAF7GbdyRg3miHNrw2bGxrd63tfMEmJob', 1000000, from_address: '1A8JiWcwvpY7tAopUkSnGuEYHmzGYfZPiq')

puts payment.tx_hash
```

### `send_many`
Send bitcoin from your wallet to multiple addresses. Returns a `PaymentResponse` object.

##### Params:
* `dictionary recipients` - hash with the structure of `str address` => `int amount` in satoshi
* `str from_address` (optional, keyword) - specific address to send from
* `int fee` (optional, keyword) - transaction fee in satoshi. Must be greater than default

##### Usage:
```ruby
recipients = { '1NAF7GbdyRg3miHNrw2bGxrd63tfMEmJob' => 1428300,
				'1A8JiWcwvpY7tAopUkSnGuEYHmzGYfZPiq' => 234522117 }
payment = wallet.send_many(recipients)

puts payment.tx_hash
```

### `get_balance`
Fetch the wallet balance. Includes unconfirmed transactions and possibly double spends. Returns the wallet balance in satoshi.

##### Usage:
```ruby
puts wallet.get_balance()
```

### `list_addresses`
List all active addresses in the wallet. Returns an array of `WalletAddress` objects.

##### Usage:
```ruby
addresses = wallet.list_addresses()
addresses.each do |a|
	puts a.balance
end

```

### `get_address`
Retrieve an address from the wallet. Returns an `WalletAddress` object.

##### Params:
* `str address` - the address to retrieve

##### Usage:
```ruby
addr = wallet.get_address('1NAF7GbdyRg3miHNrw2bGxrd63tfMEmJob')
puts addr.balance
```

### `new_address`
Generate a new address and add it to the wallet. Returns an `WalletAddress` object.

##### Params:
* `str label` (optional, keyword) - label to attach to the address

##### Usage:
```ruby
newaddr = wallet.new_address('test_label')
```

### `archive_address`
Archive an address. Returns a string representation of the archived address.

##### Params:
* `str address` - address to archive

##### Usage:
```ruby
wallet.archive_address('1NAF7GbdyRg3miHNrw2bGxrd63tfMEmJob')
```

### `unarchive_address`
Unarchive an address. Returns a string representation of the unarchived address.

##### Params:
* `str address` - address to unarchive

##### Usage:
```ruby
wallet.unarchive_address('1NAF7GbdyRg3miHNrw2bGxrd63tfMEmJob')
```

## Response Object Properties

### WalletAddress Object
* `balance`
* `address`
* `label`
* `total_received`

### PaymentResponse Object
* `message`
* `tx_hash`
* `notice`