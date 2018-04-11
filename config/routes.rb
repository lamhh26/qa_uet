Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root "static_pages#home"
  resources :users, except: %i(create destroy) do
    member do
      get :answers, :questions, :tags
    end
    resources :categories, only: :show
  end
  resources :questions, controller: :posts do
    resources :comments, controller: :question_comments, except: %i(index show new)
    resources :answers, except: %i(index show new) do
      member do
        post :upvote, :downvote
      end
    end
    member do
      post :upvote, :downvote
    end
  end
  scope "answers/:answer_id", as: :answer do
    resources :comments, controller: :answer_comments, except: %i(index show new)
  end
  resource :unanswered, only: :show
  resource :tags, only: :show do
    collection do
      get :search
    end
  end
  get "/questions/tagged/:name", to: "posts#tagged", as: :tagged_questions
  get "/unanswered/tagged/:name", to: "unanswereds#tagged", as: :tagged_unanswered
  get "*path", to: "application#page_404"
end
