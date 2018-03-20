Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :users
  resources :questions, only: %i(index show) do
    get :tagged, on: :collection
  end
  resource :unanswered, only: :show
  get "*path", to: "application#page_404"
end
