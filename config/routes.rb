Rails.application.routes.draw do
  get "/articles" => "articles#index"
  get "/articlesusingruby" => "articles#index"


  namespace :api do
    namespace :v1 do
      get "/articles" => "articles#index"
      
      get "/favorites" => "favorites#index"
      post "/favorites" => "favorites#create"

      get "/sources" => "sources#index"

      get "/usersources" => "user_sources#index"
      post "/usersources" => "user_sources#create"
    end
  end

  post "/favorites" => "favorites#create"
  delete "/favorites/:id" => "favorites#destroy"

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/users/:id" => "users#show"

end
