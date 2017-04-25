# Push transaction functionality

Initialize an instance of the `PushTx` class:

```ruby
# as with other classes, you can set optional params base_url and / or api_code

require 'Blockchain'
push_tx = Blockchain::PushTx.new
```

## Methods

### `pushtx`
Call the pushtx endpoint and broadcast a hex encoded transaction. The method does not return anything upon success, but will raise exceptions if the transaction is malformed.

##### Params:
* `str tx` (hex encoded)

##### Usage:
```ruby
push_tx.pushtx( '0100000001fd468e431cf5797b108e4d22724e1e055b3ecec59af4ef17b063afd36d3c5cf6010000008c4930460221009918eee8be186035be8ca573b7a4ef7bc672c59430785e5390cc375329a2099702210085b86387e3e15d68c847a1bdf786ed0fdbc87ab3b7c224f3c5490ac19ff4e756014104fe2cfcf0733e559cbf28d7b1489a673c0d7d6de8470d7ff3b272e7221afb051b777b5f879dd6a8908f459f950650319f0e83a5cf1d7c1dfadf6458f09a84ba80ffffffff01185d2033000000001976a9144be9a6a5f6fb75765145d9c54f1a4929e407d2ec88ac00000000')

```
