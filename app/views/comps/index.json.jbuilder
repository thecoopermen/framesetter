json.comps @comps do |comp|
  json.(comp, :name, :created_at, :updated_at)
  json.image comp.image.url
end
