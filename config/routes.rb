Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  get 'contact', to: 'contact_messages#new', as: 'new_message'
  post 'contact', to: 'contact_messages#create', as: 'create_message'
  post 'subscribe', to: 'welcome#subscribe', as: 'subscribe_email'

  get 'subscriptions', to: 'subscriptions#index'
end
