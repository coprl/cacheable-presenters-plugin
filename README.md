# Cacheable Presenter Plugin

A [COPRL](http://github.com/coprl/coprl) presenter plugin for Russian doll / fragment caching of pom views

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cacheable_presenter_plugin', git: 'https://github.com/coprl/cacheable_presenter_plugin', require: false
```

And then execute:

    $ bundle


## Usage in POMs

Declare the plugin in your pom, `plugin :cacheable`, or configure it globally:

```
Coprl::Presenters::Settings.configure do |config|
config.presenters.plugins.push(:cacheable)
end
```

Start a cache block with a key like so:

```
cache :saved do
  title 'Foo'
end
```

Simply wrap your POM with the cache directive. 

Complex keys are supported.  If an object responds to `cache_key` then
that will be used for it.  An object that responds to `map` will be
expanded.  As a last resort `to_s` is used.

```
cache [:saved, product] do
  title 'Product details'
end
```

## Configuration

The cache function can be set to work with an apps implementation of
caching.  The function must take the key, options as arguments and a block
for when there is a cache miss.

With Rails it will default to:

```
Voom::Presenters::Plugins::Cacheable::Settings.configure do |config|
# A cache needs to respond to fetch(key, &block) and exist?(key) or has_key?(key)
  config.cache_func = Rails.cache.method(:fetch)
end
```

For other Rack apps you need to configure it with a block:

```
Coprl::Presenters::Plugins::Cacheable::Settings.configure do |config|
    # A cache needs to respond to fetch(key, &block) and exist?(key) or has_key?(key)
    config.cache=cache_store
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coprl/chart_presenter_plugin.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the COPRL project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/coprl/coprl/blob/master/CODE-OF-CONDUCT.md).
