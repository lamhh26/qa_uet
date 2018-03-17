Rails.application.routes.draw do
  devise_for :users
  root "static_pages#show", page: "home"
  get "/static_pages/*page", to: "static_pages#show"
  get "*path", to: "application#page_404"
end
