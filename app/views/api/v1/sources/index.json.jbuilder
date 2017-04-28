json.array! @sources.each do |source|
  json.source source["source"]
  # json.selected current_user.
  if current_user
    json.selected current_user.has_source_name?(source["source"])
  end
end