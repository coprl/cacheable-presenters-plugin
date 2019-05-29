require_relative 'cacheable/component'
require_relative 'cacheable/mixins/cache_store'

module Voom
  module Presenters
    module Plugins
      module Cacheable

        class Settings
          extend Dry::Configurable
          # A cache needs to respond to fetch(key, &block) and exist?(key)
          setting :cache, defined?(Rails) ? Rails.cache : nil
        end

        module DSLComponents
          def cache(key_or_collection, **attrs, &block)
            self << Cacheable::Component.new(key_or_collection, parent: self, **attrs, &block)
          end
        end

        module WebClientComponents
          include Mixins::CacheStore
          def render_cacheable(comp, render:, components:, index:)
            render_proc = Proc.new { render.call :erb, :'components/render', locals: { components: comp.components, scope: nil } }

            if cache_store
              cache_store.fetch comp.cache_key, comp.attribs, &render_proc
            else
              render_proc.call
            end
          end
        end

      end
    end
  end
end
