require 'forwardable'

module Analytics
  module Configurable
    extend Forwardable
    
    attr_accessor :consumer_key, :consumer_secret, :default_access_token

    def configure
      yield self
      self
    end

    def options
      {
        :consumer_key         => consumer_key,
        :consumer_secret      => consumer_secret,
        :default_access_token => default_access_token
      }
    end
  end
end
