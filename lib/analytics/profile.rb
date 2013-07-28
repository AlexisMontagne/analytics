module Analytics
  class Profile
    attr_reader :web_property_id, :name, :id, :url, :account_id
    
    def initialize(opts, access_token)
      @access_token = access_token
      @name = opts.fetch("name")
      @id = opts.fetch("id")
      @url = opts.fetch("websiteUrl")
      @web_property_id = opts.fetch("webPropertyId")
      @account_id = opts.fetch("accountId")
    end

    def report
      @report ||= Analytics::Report.new(@id, @access_token)
    end

  private
    def method_missing(method_name, *args, &block)
      report.send(method_name, args, block)
    end
  end  
end
