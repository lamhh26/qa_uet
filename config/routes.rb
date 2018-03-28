Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root "static_pages#home"
  resources :users, only: %i(index show)
  resources :questions, controller: :posts do
    resources :comments, controller: :question_comments
    resources :answers
  end
  scope "answers/:answer_id", as: :answer do
    resources :comments, controller: :answer_comments
  end
  resource :unanswered, only: :show
  resource :tags, only: :show do
    get :search, on: :collection
  end
  get "/questions/tagged/:name", to: "posts#tagged", as: :tagged_questions
  get "/unanswered/tagged/:name", to: "unanswereds#tagged", as: :tagged_unanswered
  get "*path", to: "application#page_404"
end
