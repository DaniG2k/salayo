Rails.application.routes.draw do
  root to: 'welcome#index'

  mount ActionCable.server => '/cable'
  require 'sidekiq/web'
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  authenticate :user, lambda {|u| u.has_role?(:admin)} do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for(
    :users,
    path: '',
    skip: [:registrations],
    path_names: { sign_in: 'login', sign_out: 'logout' }
  )
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', as: 'user_registration'
  end
  resources :users, only: [:show]

  get 'contact', to: 'contact_messages#new', as: 'new_contact_message'
  post 'contact', to: 'contact_messages#create', as: 'create_message'
  post 'subscribe', to: 'welcome#subscribe', as: 'subscribe_email'
  get 'dashboard', to: 'dashboard#index'
  get 'search', to: 'dashboard#search'
  get 'privacy_policy', to: 'welcome#privacy_policy'
  get 'terms', to: 'welcome#terms'

  namespace :admin do
    root 'application#index'
    get 'subscriptions', to: 'subscriptions#index'
    get 'users', to: 'users#index'
  end

  resources :listings do
    member do
      post 'add_picture', to: 'listings#add_picture'
    end
    #resources :pictures, only: [:create]
  end

  resources :advertisements do
    collection do
      get 'mine', as: :my
    end
    member do
      post 'add_picture', to: 'advertisements#add_picture'
    end
  end
  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end
  get 'messages', to: 'chatrooms#messages'
end
