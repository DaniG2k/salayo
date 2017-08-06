Rails.application.routes.draw do
  get 'listings/index'

  get 'listings/new'

  get 'listings/create'

  get 'listings/show'

  get 'listings/edit'

  get 'listings/update'

  get 'listings/destroy'

  devise_for :users, skip: [:registrations], path: '', path_names: { sign_in: 'login', sign_out: 'logout' }
  root 'welcome#index'

  get 'contact', to: 'contact_messages#new', as: 'new_message'
  post 'contact', to: 'contact_messages#create', as: 'create_message'
  post 'subscribe', to: 'welcome#subscribe', as: 'subscribe_email'
  get 'subscriptions', to: 'subscriptions#index'
  get 'dashboard', to: 'dashboard#index'
  get 'search', to: 'dashboard#search'

  resources :listings
end
