Rails.application.routes.draw do

  post "posts/:post_id/applies/:id/:state" => "applies#update"
  get "notes/:user_id" => "users#notes"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  resources :users do
    resources :books, only: [:create, :destroy]
  end
  resources :posts do
    resources :applies, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
