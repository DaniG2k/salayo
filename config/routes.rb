Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  require 'sidekiq/web'
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '' => redirect("/#{I18n.default_locale}")
  scope '/:locale', locale: /en|ja|ko/ do
    root to: 'welcome#index'
    get 'contact', to: 'contact_messages#new', as: 'new_contact_message'
    post 'contact', to: 'contact_messages#create', as: 'create_message'
    post 'subscribe', to: 'welcome#subscribe', as: 'subscribe_email'
    get 'privacy_policy', to: 'welcome#privacy_policy'
    get 'terms', to: 'welcome#terms'

    devise_for(
      :users,
      path: '',
      controllers: { registrations: 'users/registrations' },
      path_names: { sign_in: 'login', sign_out: 'logout' }
    )

    resources :users, only: %i[show]
    get 'dashboard', to: 'dashboard#index'
    get 'search', to: 'dashboard#search'

    namespace :admin do
      root 'application#index'
      get 'subscriptions', to: 'subscriptions#index'
      resources :users, only: %i[index destroy]
      resources :contact_messages, only: %i[index show destroy]
    end

    resources :listings do
      collection do
        get 'mine', as: :my
      end
    end

    resources :advertisements do
      collection do
        get 'mine', as: :my
      end
    end
    resources :chatrooms, only: %i[show create] do
      resource :chatroom_users, only: %i[create]
      resources :messages
    end
    get 'messages', to: 'chatrooms#messages'
  end
end
