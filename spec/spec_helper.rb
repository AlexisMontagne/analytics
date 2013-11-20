require 'analytics'
require 'coveralls'
Coveralls.wear!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
end
