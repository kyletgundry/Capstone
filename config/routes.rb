Rails.application.routes.draw do
  get "/articles" => "articles#index"

  namespace :api do
    namespace :v1 do
      get "/articles" => "articles#index"
      # post "/articles" => "articles#create"
      # get "/articles/:id" => "articles#show"
      # patch "/articles/:id" =>  "articles#update"
      # delete "/articles/:id" => "articles#destroy"
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
