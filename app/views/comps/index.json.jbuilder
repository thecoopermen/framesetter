json.comps @comps do |comp|
  json.(comp, :name, :created_at, :updated_at)
  json.image {
    json.original comp.image.url(:original)
    json.thumbnail comp.image.url(:thumbnail)
  }
end
