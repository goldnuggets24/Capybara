json.array!(@pictures) do |picture|
  json.extract! picture, :id, :image, :score
  json.url picture_url(picture, format: :json)
end
