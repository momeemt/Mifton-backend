Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
  namespace :api, format: 'json' do
    namespace :v1 do
      get 'users/user_id/:id', to: 'users#acquisition_at_user_id'
      resources :users
      resources :drops
      resources :topics
      resources :sessions
      resources :news
      resources :convenience_links
    end
  end
end
