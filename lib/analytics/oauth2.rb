require 'forwardable'
require 'oauth2'
module Analytics
  module OAuth2
    extend Forwardable

    def oauth_client
      @oauth_client ||= ::OAuth2::Client.new(
        consumer_key, 
        consumer_secret,
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
