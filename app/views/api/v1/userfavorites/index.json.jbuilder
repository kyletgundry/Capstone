json.array! @user_favorites.each do |userfavorite|
  json.userfavorite_id userfavorite["id"]
  json.user_id userfavorite["user_id"]
  json.favorite_id userfavorite["favorite_id"]
end