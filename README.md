# Cacheable Plugin

This plugin allows russian doll / fragment caching of pom views

## Usage in POMs

Start a cache block with a key like so:

```
cache :saved do
  title 'Foo'
end
```

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
  config.cache_func = Rails.cache.method(:fetch)
end
```
