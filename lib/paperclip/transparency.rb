class Paperclip::Transparency < Paperclip::Processor

  def make
    prefix = "#{options[:style]}_"

    if attachment.instance.respond_to?(:"#{prefix}left") && options[:style].to_s.end_with?('_0')
      chunky = ChunkyPNG::Image.from_file(file.path)
      pixelr = Pixelr.new(chunky)

      biggest = pixelr.areas.max_by { |area| area[2] }
      attachment.instance.assign_attributes(
        :"#{prefix}full_width" => chunky.width,
        :"#{prefix}full_height" => chunky.height,
        :"#{prefix}left" => biggest[0][0],
        :"#{prefix}top" => biggest[0][1],
        :"#{prefix}width" => biggest[1][0] - biggest[0][0] + 1,
        :"#{prefix}height" => biggest[1][1] - biggest[0][1] + 1
      )
    end

    File.new(@file.path)
  end
end
