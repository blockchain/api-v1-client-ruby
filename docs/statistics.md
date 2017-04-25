# Statistics functionality

Initialize an instance of the `StatisticsExplorer` class:

```ruby
# as with other classes, you can set optional params base_url and / or api_code

require 'Blockchain'
explorer = Blockchain::StatisticsExplorer.new
```

## Methods

### `get_statistics`
Get network statistics. Returns a `StatisticsResponse` object.

##### Usage:
```ruby
stats = explorer.get_statistics()
```

### `get_chart`
Get data from a Blockchain.info chart. Returns a `ChartResponse` object.

##### Params
* `str chart_type` - the name of the chart to get data for
* `str timespan` (optional) - the duration of the chart (1 year by default in most cases, 1 week for mempool charts)
* `str rolling_average` (optional) - the duration over which data should be averaged

##### Usage
```ruby
chart_stats = explorer.get_chart('transactions-per-second', '5weeks', '8hours')
```

### `get_pools`
Get all mining pools and the total blocks they each mined in the last 4 days. Returns a `str` => `int` hash.

##### Params
* `int timespan` (optional) - number of days to get data for (default 4, maximum 10)

##### Usage
```ruby
pool_stats = explorer.get_pools(8)
```