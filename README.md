# Blockchain API library (Ruby, v1)

An official Ruby gem for interacting with the Blockchain.info API.

### Release notes

This gem was recently updated to support additional functionality of the Blockchain API. As part of this process, the archticture was changed. Rather than calling static methods under the Blockchain module, applications can now create instances of different classes supporting different Blockchain API endpoints. Calling the static methods will still work, but these have been deprecated.

### Getting started

Installation via RubyGems:

```
$ gem install blockchain
```

Manual installation:
```
$ git clone https://github.com/blockchain/api-v1-client-ruby
$ cd api-v1-client-ruby
$ rake install
```

To use the `wallet` and `createwallet` functionality, you'll also need an instance of [service-my-wallet][my-wallet].

The gem consists of the following functionality:

* `blockexplorer` ([docs](docs/blockexplorer.md)) ([api/blockchain_api][api1])
* `createwallet` ([docs](docs/createwallet.md)) ([api/create_wallet][api2])
* `exchangerates` ([docs](docs/exchangerates.md)) ([api/exchange\_rates\_api][api3])
* `pushtx` ([docs](docs/pushtx.md)) ([pushtx][api7])
* `receive` ([docs](docs/receive.md)) ([api/api_receive][api4])
* `statistics` ([docs](docs/statistics.md)) ([api/charts_api][api5])
* `wallet` ([docs](docs/wallet.md)) ([api/blockchain\_wallet\_api][api6])

The main module is called `Blockchain`

### The Client class

Every class instance creates an instance of the client class, which is used to make calls to the API. The client instance will be created with a default base url if none is provided. You can also provide an API code when creating an instance of any class. For example:

```ruby
require 'Blockchain'

# creates a block explorer instance pointing to the default base url, https://blockchain.info/, with no api code
explorer = Blockchain::BlockExplorer.new
# creates a block explorer pointing to an alternative base url and using an api code
explorer = Blockchain::BlockExplorer.new('http://some-other-url.com/', 'api-code')
```

### Error handling

All functions may raise exceptions caused by incorrectly passed parameters or other problems. If a call is rejected server-side, the `APIException` exception will be raised.

### Connection timeouts

It is possible to set arbitrary connection timeouts.

```ruby
require 'Blockchain'
Blockchain::TIMEOUT_SECONDS = 5 #time out after 5 seconds
```

### Request limits and API keys

In order to prevent abuse some API methods require an API key approved with some basic contact information and a description of its intended use. Please request an API key [here](https://blockchain.info/api/api_create_code).

The same API key can be used to bypass the request limiter.

[my-wallet]: https://github.com/blockchain/service-my-wallet-v3
[api1]: https://blockchain.info/api/blockchain_api
[api2]: https://blockchain.info/api/create_wallet
[api3]: https://blockchain.info/api/exchange_rates_api
[api4]: https://blockchain.info/api/api_receive
[api5]: https://blockchain.info/api/charts_api
[api6]: https://blockchain.info/api/blockchain_wallet_api
[api7]: https://blockchain.info/pushtx
