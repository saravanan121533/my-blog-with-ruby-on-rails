Rails.application.routes.draw do
  #root "home#home"
  root "posts#index"
  get "/about" => "home#about"

  # routes for blog posts and user comments on a blog post
  resources :posts do
    resources :comments
  end

  # routes for user Sign-Up
  resources :users, only:[:new, :create]

  # routes for user Log-in and Log-out
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
