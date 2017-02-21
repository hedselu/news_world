Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :users do
        post 'sign_up', to: 'users#create'
        delete ':id', to: 'users#destroy'
        post 'sign_in', to: 'session#create'
        delete 'sign_out', to: 'session#destroy'
        get '', to: 'users#index'
      end

      namespace :users do
        scope :me do
          get 'news', to: 'category_news#index'
          get 'news/top', to: 'top_news#index'
          get 'news/followed_people', to: 'followed_people_news#index'
          get '', to: 'accounts#show'
          put '', to: 'accounts#update'
          post 'password', to: 'passwords#create'
          resources :followed_people, except: %i(new show edit)
        end
      end

      resources :news do
        post 'votes', to: 'votes#create'
        put 'votes', to: 'votes#update'
      end

      resources :news, only: %i(show index destroy)
      get 'categories', to: 'categories#index'
    end
  end
  root to: 'application#angular'
end
