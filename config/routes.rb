Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root "static_pages#home"
  resources :users, except: %i(create destroy) do
    member do
      get :answers, :questions, :tags
      get "/categories/:category_id", to: "users#categories", as: :category
    end
  end
  resources :courses, only: :show do
    resources :questions, controller: :posts, only: %i(index)
    get "/questions/tagged/:name", to: "posts#tagged", as: :tagged_questions
    get "/unanswered/tagged/:name", to: "unanswereds#tagged", as: :tagged_unanswered
    resource :unanswered, only: :show
    resource :tags, only: :show do
      collection do
        get :search
      end
    end
  end
  resources :questions, controller: :posts, except: %i(index) do
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
  get "*path", to: "application#page_404"
end
