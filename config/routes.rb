Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :users
  resources :questions, only: %i(index show)
  resource :unanswered, only: :show
  resource :tags, only: :show
  get "/questions/tagged/:name", to: "questions#tagged", as: :tagged_questions
  get "/unanswered/tagged/:name", to: "unanswereds#tagged", as: :tagged_unanswered
  get "*path", to: "application#page_404"
end
