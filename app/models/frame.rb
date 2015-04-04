class Frame < ActiveRecord::Base
  belongs_to :frameset
  has_many :renders, dependent: :nullify

  has_attached_file :image, processors: [ :thumbnail, :transparency ], styles: {
    original_0: {},
    original_90: { convert_options: '-rotate 90' },
    original_180: { convert_options: '-rotate 180' },
    original_270: { convert_options: '-rotate 270' },

    preview_0: '550x400',
    preview_90: { geometry: '400x550', convert_options: '-rotate 90' },
    preview_180: { geometry: '550x400', convert_options: '-rotate 180' },
    preview_270: { geometry: '400x550', convert_options: '-rotate 270' },

    thumbnail_0: '120x120',
    thumbnail_90: { geometry: '120x120', convert_options: '-rotate 90' },
    thumbnail_180: { geometry: '120x120', convert_options: '-rotate 180' },
    thumbnail_270: { geometry: '120x120', convert_options: '-rotate 270' },

    thumbnail: '64x64'
  }

  before_save :extract_scales
  after_commit :copy_coordinates, if: :copy_required?

  validates_attachment :image, content_type: { content_type: ['image/png'] }

private

  def extract_scales
    return unless image?

    [ :preview ].each do |style|
      [ 0, 90, 180, 270 ].each do |rotation|
        original = image.queued_for_write[:"original_#{rotation}"]
        scaled = image.queued_for_write[:"#{style}_#{rotation}"]
        unless original.nil? || scaled.nil?
          original_geometry = Paperclip::Geometry.from_file(original)
          scaled_geometry = Paperclip::Geometry.from_file(scaled)
          write_attribute(:"#{style}_#{rotation}_scale", scaled_geometry.width.to_f / original_geometry.width.to_f)
        end
      end
    end
  end

  def copy_required?
    [ :original, :preview, :thumbnail ].any? do |base|
      [ :left, :top, :width, :height ].any? do |attr|
        previous_changes.keys.include?("#{base}_0_#{attr}")
      end
    end
  end

  def copy_coordinates
    image.styles.keys.each do |style|
      if style.to_s =~ /_\d{2,3}$/
        base = style.to_s.sub(/_\d+$/, '')
        copy_90_degrees(base)
        copy_180_degrees(base)
        copy_270_degrees(base)
      end
    end
    save!
  end

  def copy_90_degrees(base)
    scale_factor = read_attribute(:"#{base}_90_scale") / read_attribute(:"#{base}_0_scale") rescue 1.0

    write_attribute(:"#{base}_90_left", scale_factor * (attributes["#{base}_0_full_height"] - attributes["#{base}_0_height"] - attributes["#{base}_0_top"]))
    write_attribute(:"#{base}_90_top", scale_factor * attributes["#{base}_0_left"])
    write_attribute(:"#{base}_90_width", scale_factor * attributes["#{base}_0_height"])
    write_attribute(:"#{base}_90_height", scale_factor * attributes["#{base}_0_width"])
  end

  def copy_180_degrees(base)
    write_attribute(:"#{base}_180_left", attributes["#{base}_0_full_width"] - attributes["#{base}_0_width"] - attributes["#{base}_0_left"])
    write_attribute(:"#{base}_180_top", attributes["#{base}_0_full_height"] - attributes["#{base}_0_height"] - attributes["#{base}_0_top"])
    write_attribute(:"#{base}_180_width", attributes["#{base}_0_width"])
    write_attribute(:"#{base}_180_height", attributes["#{base}_0_height"])
  end

  def copy_270_degrees(base)
    scale_factor = read_attribute(:"#{base}_270_scale") / read_attribute(:"#{base}_0_scale") rescue 1.0

    write_attribute(:"#{base}_270_left", scale_factor * attributes["#{base}_0_top"])
    write_attribute(:"#{base}_270_top", scale_factor * (attributes["#{base}_0_full_width"] - attributes["#{base}_0_width"] - attributes["#{base}_0_left"]))
    write_attribute(:"#{base}_270_width", scale_factor * attributes["#{base}_0_height"])
    write_attribute(:"#{base}_270_height", scale_factor * attributes["#{base}_0_width"])
  end
end
