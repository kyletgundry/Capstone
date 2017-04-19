Rails.application.routes.draw do
  get "/articles" => "articles#index"
  patch "/articles" => "articles#update"

  # resources :articles do
  #   put :favorites, on: :users
  # end

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/users/:id" => "users#show"

end
