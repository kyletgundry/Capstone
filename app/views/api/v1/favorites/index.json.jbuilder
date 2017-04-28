json.array! @favorites.each do |favorite|
  json.favoriteId favorite["id"]
  json.url favorite["url"]
end