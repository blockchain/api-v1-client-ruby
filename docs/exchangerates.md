# Exchange Rates functionality

Initialize an instance of the `ExchangeRateExplorer` class:

```ruby
# as with other classes, you can set optional params base_url and / or api_code

require 'blockchian'
explorer = ExchangeRateExplorer.new
```

## Methods

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
* `str ccy` - currency code to convert from
* `float value` - amount in selected currency

##### Usage:
```ruby
btc_amount = explorer.to_btc('USD', 4342.11)
```

### `from_btc`
Convert c value in satoshi to the provided currency. Returns a `float`

##### Params:
* `str currency` - currency code to convert to
* `float satoshi_value` - amount of satoshi to convert