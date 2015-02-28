json.framesets @framesets do |frameset|
  json.(frameset, :name, :created_at, :updated_at)
  json.icon frameset.icon.url

  json.frames frameset.frames do |frame|
    json.(frame, :name, :created_at, :updated_at)
    json.images [ :original, :preview ].inject({}) { |hash, style|
      hash.merge(
        style => [ 0, 90, 180, 270 ].inject({}) { |hash, rotation|
          hash.merge(
            rotation => {
              image: frame.image.url(:"#{style}_#{rotation}"),
              top: frame.send(:"#{style}_#{rotation}_top") || 0,
              left: frame.send(:"#{style}_#{rotation}_left") || 0,
              width: frame.send(:"#{style}_#{rotation}_width") || 0,
              height: frame.send(:"#{style}_#{rotation}_height") || 0,
            }
          )
        }
      )
    }
  end
end
