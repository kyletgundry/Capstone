json.array! @usersources.each do |usersource|
  json.user_source_id usersource["id"]
  json.user_id usersource["user_id"]
  json.source_id usersource["source_id"]
end