Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, skip: [:registrations], path: '', path_names: { sign_in: 'login', sign_out: 'logout' }
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  get 'contact', to: 'contact_messages#new', as: 'new_message'
  post 'contact', to: 'contact_messages#create', as: 'create_message'
  post 'subscribe', to: 'welcome#subscribe', as: 'subscribe_email'
  get 'dashboard', to: 'dashboard#index'
  get 'search', to: 'dashboard#search'

  namespace :admin do
    root 'application#index'
    get 'subscriptions', to: 'subscriptions#index'
  end

  resources :listings
end
