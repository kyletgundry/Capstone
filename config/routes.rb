Rails.application.routes.draw do
  get "/articles" => "articles#index"
  # resources :articles do
  #   put :favorite, on: :member
  # end
  post "/favorites" => "favorites#create"
  delete "/favorites/:id" => "favorites#destroy"

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/users/:id" => "users#show"

end
