Rails.application.routes.draw do
  root 'welcome#index'

  get 'contact', to: 'contact_messages#new', as: 'new_message'
  post 'contact', to: 'contact_messages#create', as: 'create_message'
  post 'register', to: 'welcome#register', as: 'register_email'
end
