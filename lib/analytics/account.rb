module Analytics
  class Account
    attr_reader :name, :id
    
    def initialize(opts, access_token)
       @name = opts.fetch("name")
       @id = opts.fetch("id")
       @access_token = access_token
    end
    
    def web_properties
      @web_properties ||= request_web_properties
    end

    def flush!
      @web_properties = nil
    end

  private
    def request_web_properties
      Analytics::Request.new(Analytics::BASE_URL, "management/accounts/#{@id}/webproperties", @access_token).response["items"].map do |item|
        Analytics::WebProperty.new(item, @access_token) rescue nil
      end.compact
    rescue 
      []
    end
  end
end
