module Analytics
  class Error < StandardError
    def initialize(exception=$!, response_headers={})
      @wrapped_exception = exception
      exception.respond_to?(:backtrace) ? super(exception.message) : super(exception.to_s)
    end
    
    def backtrace
      @wrapped_exception.respond_to?(:backtrace) ? @wrapped_exception.backtrace : super
    end
  end
end
