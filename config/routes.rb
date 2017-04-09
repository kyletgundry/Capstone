Rails.application.routes.draw do
  get "/articles" => "articles#index"
  get "/filter" => "articles#filter"
end
