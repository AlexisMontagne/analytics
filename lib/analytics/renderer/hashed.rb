module Analytics
  module Renderer
    class Hashed
      def self.render(data, metrics, dimensions)
        if (dimensions + metrics).length > 1
          data.map do |res|
            apply!(data, metrics, dimensions) 
          end
        else
          data.first
        end
      end

      def self.apply!(data, metrics, dimensions)
        elt, itr = {}, 0
        (dimensions + metrics).each do |d|
          elt[d] = data[itr]
          itr += 1
        end
        elt
      end
    end
  end
end

