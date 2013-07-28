module Analytics
  class Report
    METRICS = [ 
      :visitors, :new_visits, :percent_new_visits,
      :visits, :bounces, :pageviews
    ]
    
    DIMENSIONS = [
      :continent, :city, :country, :date, :year, 
      :month, :week, :day, :hour
    ]


    attr_reader :id, :access_token

    def initialize(id, access_token, renderer = Analytics::Renderer::Plain)
      @id = id
      @access_token = access_token
      @renderer = renderer
    end

    def get(start_date, end_date, metrics, dimensions = [])
      Analytics::Request.new(Analytics::BASE_URL, get_url(start_date, end_date, metrics, dimensions), @access_token).response["rows"].map do |row|
        @renderer.render(row, metrics, dimensions)
      end 
    end

  private
    def get_url(start_date, end_date, metrics, dimensions)
      str = "data/ga?ids=ga:#{@id}&start-date=#{start_date.strftime("%F")}&end-date=#{end_date.strftime("%F")}&metrics=#{to_ga(metrics)}"
      str += "&dimensions=#{to_ga(dimensions)}" unless dimensions.empty?
      str
    end

    def split_by(method, det = 'and')
       method.to_s.split("_#{det}_").map(&:to_sym)
    end

    def to_ga(array)
      array.map { |x| 'ga:' + x.to_s.camelize(:lower) }.join(",")
    end

    def method_missing(m, *args, &block)
      if METRICS.include? m.to_sym
        get(args[0],args[1], [m.to_sym])
      elsif m.to_s.split('_by_').length.eql? 2
        lhs, rhs = split_by(m, 'by')
        get(args[0],args[1], split_by(lhs), split_by(rhs))
      elsif split_by(m).length.eql? 2
        get(args[0],args[1], split_by(m), [])
      else
        super
      end
    end
  end
end
