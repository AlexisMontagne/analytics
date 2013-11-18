require 'forwardable'
require 'oauth2'
module Analytics
  class OAuth2
    class << self
      def oauth_client
        @oauth_client ||= ::OAuth2::Client.new(
          Analytics.consumer_key, 
          Analytics.consumer_secret,
          :site => 'https://accounts.google.com',
          :authorize_url => '/o/oauth2/auth',
          :token_url => '/o/oauth2/token'
        )
      end

      def access_token(token, opts = {})
        if token.nil?
          raise Analytics::Error::NoAccessTokenProvided
        elsif token.is_a? ::OAuth2::AccessToken
          token
        else
          ::OAuth2::AccessToken.new(oauth_client, token, opts)
        end
      end
    end
  end
end
