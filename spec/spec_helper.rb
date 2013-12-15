require 'coveralls'
Coveralls.wear!

require 'analytics-rb'
require 'vcr'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb
end

RSpec.configure do |config|
  config.mock_with :mocha
end
