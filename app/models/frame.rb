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

  after_commit :copy_coordinates, if: :copy_required?

  validates_attachment :image, content_type: { content_type: ['image/png'] }

private

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
    write_attribute(:"#{base}_90_left", attributes["#{base}_0_full_height"] - attributes["#{base}_0_height"] - attributes["#{base}_0_top"])
    write_attribute(:"#{base}_90_top", attributes["#{base}_0_left"])
    write_attribute(:"#{base}_90_width", attributes["#{base}_0_height"])
    write_attribute(:"#{base}_90_height", attributes["#{base}_0_width"])
  end

  def copy_180_degrees(base)
    write_attribute(:"#{base}_180_left", attributes["#{base}_0_full_width"] - attributes["#{base}_0_width"] - attributes["#{base}_0_left"])
    write_attribute(:"#{base}_180_top", attributes["#{base}_0_full_height"] - attributes["#{base}_0_height"] - attributes["#{base}_0_top"])
    write_attribute(:"#{base}_180_width", attributes["#{base}_0_width"])
    write_attribute(:"#{base}_180_height", attributes["#{base}_0_height"])
  end

  def copy_270_degrees(base)
    write_attribute(:"#{base}_270_left", attributes["#{base}_0_top"])
    write_attribute(:"#{base}_270_top", attributes["#{base}_0_full_width"] - attributes["#{base}_0_width"] - attributes["#{base}_0_left"])
    write_attribute(:"#{base}_270_width", attributes["#{base}_0_height"])
    write_attribute(:"#{base}_270_height", attributes["#{base}_0_width"])
  end
end
