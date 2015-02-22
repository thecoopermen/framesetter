json.framesets @framesets do |frameset|
  json.(frameset, :name, :created_at, :updated_at)
  json.icon frameset.icon.url

  json.frames frameset.frames do |frame|
    json.(frame, :name, :created_at, :updated_at, :top, :left, :width, :height)
    json.image frame.image.url
  end
end
