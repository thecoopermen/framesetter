class Paperclip::Transparency < Paperclip::Processor

  def make
    Magick::Image.read(file.path).first.channel(Magick::AlphaChannel).each_pixel do |pixel, c, r|
      if pixel.intensity > 0
        if area = find_area(c, r)
          area[1] = [c, r]
          area[2] += 1
        else
          areas << [[c, r], [c, r], 1]
        end
      end
    end

    biggest = areas.max_by { |area| area[2] }
    attachment.instance.assign_attributes(
      left: biggest[0][0],
      top: biggest[0][1],
      width: biggest[1][0] - biggest[0][0] + 1,
      height: biggest[1][1] - biggest[0][1] + 1
    )

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
