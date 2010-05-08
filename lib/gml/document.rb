module Tagdraw
  module GML
    class Document
      attr_accessor :strokes

      def initialize(string_or_io)
        @xmldoc = Nokogiri::XML(string_or_io)
        @strokes = Array.new
        parse
      end

      def parse
        stroke_nodes = (@xmldoc/'drawing'/'stroke')
        stroke_nodes.each { |stroke_node|
          stroke = Stroke.new
          (stroke_node/'pt').each { |pt_node|
            point = Point.new
            point.x = (pt_node/'x')[0].content.to_f
            point.y = (pt_node/'y')[0].content.to_f
            point.z = (pt_node/'z')[0].content.to_f
            stroke.points << point
          }
          @strokes << stroke
        }
      end

      def render(filename, opts = {})
        defaults = {:width => 320, :height => 480, :scale => 1,
          :color => 'white', :bgcolor => 'black'}

        opts = defaults.merge(opts)
        opts[:width] *= opts[:scale]
        opts[:height] *= opts[:scale]

        canvas = Magick::Image.new(opts[:width], opts[:height]) {
          self.background_color = opts[:bgcolor]
        }

        gc = Magick::Draw.new
        gc.stroke(opts[:color])
        gc.stroke_width(10 * opts[:scale])
        gc.fill_opacity(0)
        gc.stroke_linecap('round')
        gc.stroke_linejoin('round')

        @strokes.each { |stroke|
          prev_point = stroke.points.first

          stroke.points.each { |point|
            gc.line((prev_point.x * opts[:width]), (prev_point.y * opts[:height]),
              (point.x * opts[:width]), (point.y * opts[:height]))

            prev_point = point
          }
        }

        gc.draw(canvas)
        canvas.rotate(-90).write(filename)
      end
    end
  end
end
