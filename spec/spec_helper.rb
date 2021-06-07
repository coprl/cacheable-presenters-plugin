require 'coprl'

def load_presenters(dir, root)
  Coprl::Presenters::App.load(dir.to_s, root)
end

def reset_presenters!
  Coprl::Presenters::App.reset!
end

def find_pom_by_key(key)
  Coprl::Presenters::App[key].call.expand(router: nil)
end
