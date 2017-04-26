# Exchange Rates functionality

Initialize an instance of the `ExchangeRateExplorer` class:

```ruby
# as with other classes, you can set optional params base_url and / or api_code

require 'Blockchain'
explorer = Blockchain::ExchangeRateExplorer.new
```

## Methods

### `get_ticker`
Call the 'ticker' method and return a dictionary of `Currency` objects. Keys are currency codes (str) and values are `Currency` objects.

##### Usage:
```ruby
ticker = explorer.get_ticker
#print the 15 min price for every currency
ticker.keys.each do |key|
	puts ticker[key].p15min
end
```

### `to_btc`
Convert x value in the provided currency to BTC. Returns a `float`.

##### Params:
* `str ccy` - code of the currency to convert from
* `float value` - amount in selected currency

##### Usage:
```ruby
btc_amount = explorer.to_btc('USD', 4342.11)
```

### `from_btc`
Convert x value in satoshi to the provided currency. Returns a `float`

##### Params:
* `str ccy` (optional) - code of the currency to convert to (default USD)
* `float satoshi_value` - amount of satoshi to convert

##### Usage:
```ruby
one_btc_usd_value = explorer.from_btc(100000000)
```

## Response Object Properties

### Currency Object
* `last`
* `buy`
* `sell`
* `symbol`
* `p15min`