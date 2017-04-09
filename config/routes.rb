Rails.application.routes.draw do
  get "/articles" => "articles#index"
end
