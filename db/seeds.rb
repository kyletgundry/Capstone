keywords = ["College Football", "Trump", "University of Michigan Football", "Chicago"]
  
keywords.each do |keyword|
  keyword = Keyword.create(
    keyword: keyword
  )
end

sources = ["CNN", "Buzzfeed", "ESPN", "Engaget", "Business-insider", "breitbart-news", "bloomberg", "bild", "bbc-sport", "bbc-news", "associated-press", "fox-sports", "fortune", "hacker-news", "mashable"]

sources.each do |source|
  source = Source.create(
    source: source
  )
  2.times do
    favorite = Favorite.create(
    url: FAKER::Internet.url,
    source_id: source.id
  )
  end
end  

first_name = ["Kyle", "Colton", "Kerin", "George", "Rene"]

keyword_instances = Keyword.all
source_instances = Source.all
favorite_instances = Favorite.all

first_name.each do |name|
  user = User.create(
    first_name: name,
    last_name: Faker::Name.last_name,
    email: "#{name}@gmail.com",
    phone_number: Faker::PhoneNumber.phone_number,
    password: "password"
  )
  4.times do
    user_keyword = UserKeyword.create(
      user_id = user.id,
      keyword_id = keyword_instances.sample.id
    )
    user_source = UserSource.create(
      user_id = user.id,
      source_id = source_instances.sample.id
    )
    user_favorite = UserFavorite.create(
      user_id = user.id,
      favorite_id = favorite_instances.sample.id
    )
  end
end




