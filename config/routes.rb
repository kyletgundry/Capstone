Rails.application.routes.draw do
  get "/articles" => "articles#index"
  post "/articles" => "articles#update"

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/users/:id" => "users#show"

end
