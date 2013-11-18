require "multi_json"

module Analytics
  class Request < Struct.new(:base_url, :relative_path, :access_token)
    def full_path
      "#{base_url.to_s}/#{relative_path.to_s}"
    end

    def request
      access_token.get(full_path).body
    rescue ::OAuth2::Error
      raise Analytics::Error::PermissionInsufficient
    end

    def response
      @response ||= MultiJson.load(request)
    end
  end
end
