require "multi_json"

module Analytics
  class Request < Struct.new(:base_url, :relative_path, :access_token)
    def full_path
      "#{base_url.to_s}/#{relative_path.to_s}"
    end

    def request
      retried = false
      begin
        access_token.get(full_path).body
      rescue ::OAuth2::Error => e
        # One of the 403 error code means that you already did 10 requests for a second
        if e.code["code"] == 403 && !retried
          sleep 1
          retried = true
          retry
        end
        raise Analytics::Error::PermissionInsufficient
      end
    end

    def response
      @response ||= MultiJson.load(request)
    end
  end
end
