Rails.application.routes.draw do
  get "/" => "articles#index"
  get "/articles" => "articles#index"
  post "/articles/keyword/create" => "articles#create"


  namespace :api do
    namespace :v1 do
      get "/articles" => "articles#index"
      
      get "/favorites" => "favorites#index"
      post "/favorites" => "favorites#create"
      post "/favorites/delete" => "favorites#destroy"

      get "/sources" => "sources#index"

      get "/usersources" => "user_sources#index"
      post "/usersources" => "user_sources#create"
      post "/usersources/delete" => "user_sources#destroy"

      get "/userfavorites" => "userfavorites#index"

      get "/keywords" => "keywords#index"
      post "/keywords" => "keywords#create"
      post "/keywords/delete" => "keywords#destroy"

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
