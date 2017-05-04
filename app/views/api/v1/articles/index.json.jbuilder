json.array! @articles.each do |article|
  json.source article["source"]
  json.author article["author"]
  json.title article["title"]
  json.description article["description"]
  json.url article["url"]
  json.urlToImage article["urlToImage"]
  json.publishedAt article["publishedAt"]
  json.favorited current_user.favorites.map {|favorite| favorite.url}.include? article["url"]
end

# json.array! @news_api_sources.each do |source|
#   json.source source["source"]
#   json.articles source["articles"]
#   # json.array! source["articles"].each do |article|
#   #   json.aurthor article["author"]
#   # json.id article.url
#   # json.id article.urlToImage
#   # json.id article.publishedAt
# end