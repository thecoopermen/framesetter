class Pixelr
  attr_accessor :chunky

  def initialize(chunky)
    self.chunky = chunky
  end

  def chunky=(chunky)
    @chunky = chunky
    process
  end

  def areas
    @areas ||= []
  end

private

  def find_area(x, y)
    areas.detect do |area|
      area_includes(area, x - 1, y) || area_includes(area, x, y - 1)
    end
  end

  def area_includes(area, x, y)
    x >= area[0][0] && x <= area[1][0] && y >= area[0][1] && y <= area[1][1]
  end

  def process
    @chunky.height.times do |r|
      @chunky.row(r).each_with_index do |pixel, c|
        if ChunkyPNG::Color.a(pixel) < 255
          if area = find_area(c, r)
            area[1] = [c, r]
            area[2] += 1
          else
            areas << [[c, r], [c, r], 1]
          end
        end
      end
    end
  end
end
