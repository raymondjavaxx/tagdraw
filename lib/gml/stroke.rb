module Tagdraw
  module GML
    class Stroke
      attr_accessor :brush, :points, :drawing

      def initialize
        @points = Array.new
      end
    end
  end
end
