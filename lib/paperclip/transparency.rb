class Paperclip::Transparency < Paperclip::Processor

  def make
    prefix = "#{options[:style]}_"

    if attachment.instance.respond_to?(:"#{prefix}left")
      chunky = ChunkyPNG::Image.from_file(file.path)
      chunky.height.times do |r|
        chunky.row(r).each_with_index do |pixel, c|
          if ChunkyPNG::Color.a(pixel) < 230
            if area = find_area(c, r)
              area[1] = [c, r]
              area[2] += 1
            else
              areas << [[c, r], [c, r], 1]
            end
          end
        end
      end

      biggest = areas.max_by { |area| area[2] }
      attachment.instance.assign_attributes(
        :"#{prefix}left" => biggest[0][0],
        :"#{prefix}top" => biggest[0][1],
        :"#{prefix}width" => biggest[1][0] - biggest[0][0] + 1,
        :"#{prefix}height" => biggest[1][1] - biggest[0][1] + 1
      )
    end

    File.new(@file.path)
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

  def areas
    @areas ||= []
  end
end
