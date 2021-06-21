require 'coprl/presenters/dsl/components/base'
require 'coprl/presenters/pluggable'
require_relative '../../../../coprl/presenters/plugins/cacheable/mixins/cache_store'

gem_dir = Gem::Specification.find_by_name('coprl').gem_dir
mixins_dir = File.join(gem_dir, 'lib', 'coprl', 'presenters', 'dsl', 'components', 'mixins')

Dir[File.join(mixins_dir, '*.rb')].each do |file|
  require File.join(mixins_dir, File.basename(file, File.extname(file)))
end

module Coprl
  module Presenters
    module Plugins
      module Cacheable

        class Component < DSL::Components::Base
          include Mixins::CacheStore
          DSL::Components::Mixins.constants(false).each do |mixin|
            const = DSL::Components::Mixins.const_get(mixin)
            if const.is_a?(Module)
              include Mixins::CacheStore
              include const
            end
          end

          extend Pluggable
          include_plugins(:DSLComponents)

          attr_reader :cache_key, :components

          def initialize(key_or_collection, **attrs, &block)
            super(type: :cacheable, **attrs, &block)

            @components = []
            @cache_key = build_cache_key(key_or_collection)

            if cache_store
              expand! unless key_exists?(@cache_key)
            else
              expand!
            end
          end

          private

          def key_exists?(key)
            # Support both exists? (Rails::Cache) and has_key? (Concurrent::Hash)
            cache_store.respond_to?(:exist?) ? cache_store.exist?(key) : cache_store.has_key?(key)
          end

          def build_cache_key(key)
            if key.respond_to?(:map)
              key.map {|k| build_cache_key(k)}.join('-')
            elsif key.respond_to?(:cache_key)
              key.cache_key
            else
              key.to_s
            end
          end

        end

      end
    end
  end
end
