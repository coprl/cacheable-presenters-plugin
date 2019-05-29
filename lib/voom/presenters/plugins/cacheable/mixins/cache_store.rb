module Voom
  module Presenters
    module Plugins
      module Cacheable
        module Mixins
          module CacheStore
            def cache_store
              Settings.config.cache
            end
          end
        end
      end
    end
  end
end
