Rails.application.routes.draw do
  root "home#home"
  get "/about" => "home#about"
end
