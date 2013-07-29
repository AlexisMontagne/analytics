module Analytics
  class Client
    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
      raise Analytics::Error::NoAccessTokenProvided if @access_token.nil?
    end

    def accounts
     @accounts ||= request_accounts
    end
    
    def web_properties
      accounts.map(&:web_properties).flatten
    end

    def profiles
      web_properties.map(&:profiles).flatten
    end

    def flush!
      @accounts = nil
    end

  private
    def request_accounts
      Analytics::Request.new(Analytics::BASE_URL, 'management/accounts', @access_token).response["items"].map do |item|
        Analytics::Account.new(item, @access_token)
      end
    end
  end
end
