require "forwardable"
require "oauth"

module Analytics
  class OAuth
    class << self
      def oauth_consumer
        @consumer ||= ::OAuth::Consumer.new(Analytics.consumer_key, Analytics.consumer_secret, {
          :site => 'https://www.google.com',
          :request_token_path => '/accounts/OAuthGetRequestToken',
          :access_token_path => '/accounts/OAuthGetAccessToken',
          :authorize_path => '/accounts/OAuthAuthorizeToken'
        })
      end

      def access_token(token, secret = nil, opts = {})
        if token.is_a? ::OAuth::AccessToken
          token
        else
          ::OAuth::AccessToken.new(oauth_consumer, token, secret)
        end
      end
    end
  end
end
