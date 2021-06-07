require 'spec_helper'

require 'coprl/presenters/plugins/cacheable'

describe Coprl::Presenters::Plugins::Cacheable do
  before do
    load_presenters :presenters, File.expand_path('../../../../', __FILE__)
  end

  after do
    reset_presenters!
  end

  it 'can accept simple keys' do
    pom = find_pom_by_key(:simple_cache_key)
    expect(pom.components.first.cache_key).to eq 'remember_me'
  end

  it 'can accept complex keys' do
    pom = find_pom_by_key(:complex_cache_key)
    expect(pom.components.first.cache_key).to eq 'title-wild-abc-123'
  end
end
