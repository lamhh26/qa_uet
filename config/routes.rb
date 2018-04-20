Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"

  devise_for :users, skip: :registrations
  devise_scope :user do
    authenticated :user do
      root "courses#index"
      get "/hot", to: "static_pages#hot", as: :hot
      resources :users, except: %i(create destroy) do
        member do
          get :answers, :questions, :tags
          get "/categories/:category_id", to: "users#categories", as: :category
        end
      end
      resources :questions, controller: :posts, only: %i(index)
      get "/questions/tagged/:name", to: "posts#tagged", as: :tagged_questions
      get "/unanswered/tagged/:name", to: "unanswereds#tagged", as: :tagged_unanswered
      resource :unanswered, only: :show
      resource :tags, only: :show do
        collection do
          get :search
        end
      end
      resources :courses, only: :show do
        resources :questions, controller: :posts, only: %i(new create)
      end
      resources :questions, controller: :posts, except: %i(new create) do
        resources :comments, controller: :question_comments, except: %i(index show new)
        resources :answers, except: %i(index show new) do
          member do
            post :upvote, :downvote
            patch :mark_best_answer, :unmark_best_answer
          end
        end
        member do
          post :upvote, :downvote
        end
      end
      scope "answers/:answer_id", as: :answer do
        resources :comments, controller: :answer_comments, except: %i(index show new)
      end
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end
  get "*path", to: "application#page_404"
end
