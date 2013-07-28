require "analytics/version"
require "analytics/configurable"
require "analytics/oauth"
require "analytics/client"
require "analytics/account"
require "analytics/web_property"
require "analytics/profile"
require "analytics/report"
require "analytics/request"
require "analytics/error"
require "analytics/error/permission_insufficient"
require "analytics/error/no_access_token_provided"
require "analytics/core_ext/string"
require "analytics/renderer/plain"
require "analytics/renderer/hashed"

module Analytics
  BASE_URL = 'https://www.googleapis.com/analytics/v3'

  class << self
    include Analytics::Configurable
    include Analytics::OAuth
    
    def client
      @client ||= Analytics::Client.new(options.fetch(:default_access_token))
    end

    def from_token(oauth_token)
       @client = Analytics::Client.new(access_token(oauth_token))
    end

  private
    def method_missing(name, *args, &block)
      client.respond_to?(name) ? client.send(name, args, block) : super
    end
  end
end
