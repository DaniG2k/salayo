Rails.application.routes.draw do
  get 'messages/create'

  get 'chatroom_users/create'

  get 'chatroom_users/destroy'

  root to: 'welcome#index'

  mount ActionCable.server => '/cable'

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
  end

  resources :listings
  resources :advertisements do
    collection do
      get 'mine', as: :my
    end
  end
  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end
  get 'messages', to: 'chatrooms#messages'
end
