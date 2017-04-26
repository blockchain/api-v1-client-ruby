# Receive Payments V2 functionality

Initialize an instance of the `Receive` class:

```ruby
# you can set optional param base_url (https://api.blockchain.info/v2/ by default).

require 'Blockchain'
receive_payment = Blockchain::V2::Receive.new
```


## Methods

### `receive`
Call the 'v2/receive' endpoint and create a new address. Returns a `V2::ReceiveResponse` object.

##### Params:
* `str xpub`
* `str callback`
* `str api_key`

##### Usage:
```ruby
resp = receive_payment.receive('xpub1hNapz1CuH4DhnV1DFHH7hafwDE8FJRheA', 'http://your.url.com', 'yourApiKey')
```

### `callback_log`
Call the 'v2/receive/callback_log' endpoint to see logs related to callback attempts. Returns an array of `LogEntry` objects.

##### Params:
* `str callback`
* `str api_key`

##### Usage:
```ruby
resp = receive_payment.callback_log('http://your.url.com', 'yourApiKey')
```

### `callback_log`
Call the 'v2/receive/checkgap' endpoint to check the index gap betweem the last address paid and the last address generated. Returns an `int`.

##### Params:
* `str xpub`
* `str api_key`

##### Usage:
```ruby
resp = receive_payment.callback_log('xpub1hNapz1CuH4DhnV1DFHH7hafwDE8FJRheA', 'yourApiKey')
```

## Response Object Properties

### ReceiveResponse Object
* `address`
* `index`
* `callback_url`

### LogEntry Object
* `callback_url`
* `called_at`
* `raw_response`
* `response_code`