# Create Wallet functionality

Initialize an instance of the `WalletCreator` class:

```ruby
require 'Blockchain'

# create an instance potining to http://127,0.0.1:3000/
wallet_creator = Blockchain::WalletCreator.new(api_code = 'your-api-code')

# create an instance pointing to an alternative base url
wallet_creator = Blockchain::BlockExplorer.new('http://some-alternative-url', 'your-api-code')
```

## Methods

### `create_wallet`
Create a new Blockchain.info wallet. It can be created containing a pre-generated private key or will otherwise generate a new private key. Returns a `CreateWalletResponse` instance.

##### Params:

* `str password` - password for the new wallet. Min. 10 characters.
* `str priv` (optional) - private key to add to the wallet.
* `str label` (optional) - label for the first address in the wallet.
* `str email` (optional) - email to associate with the new wallet.


##### Usage:
```ruby
new_wallet = wallet_creator.create_wallet('1234password', label = 'Test wallet')
```

## Response Object Properties

### CreateWalletResponse Object
* `identifier`
* `address`
* `label`