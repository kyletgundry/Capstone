json.array! @keywords.each do |keyword|
  json.id keyword["id"]
  json.user_id keyword["user_id"]
  json.keyword keyword["keyword"]
  json.user_keyword current_user.keywords.map {|keyword| keyword.keyword}.include? keyword["keyword"]
end