Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
  namespace :api, format: 'json' do
    namespace :v1 do
      get 'users/user_id/:id', to: 'users#acquisition_at_user_id'
      get 'posts', to: 'posts#index'
      resources :users
      resources :drops
      resources :topics
      resources :sessions
      resources :news
      resources :convenience_links
      resources :reports
      resources :notifications
      resources :account_activations, only: [:edit]
      resources :password_resets, only: [:new, :create, :edit, :update]
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
