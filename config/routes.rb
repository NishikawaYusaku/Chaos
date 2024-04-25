Rails.application.routes.draw do
  root 'vtubers#index'

  # get "search", to: "searches#search"

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get '/vtubers/autocomplete_names', to: 'vtubers#autocomplete_names'
  post '/vtubers/name_input', to: 'vtubers#name_input'

  resources :vtubers, only: %i[new create show edit update] do
    post 'favorite', to: 'favorites#create'
    delete 'favorite', to: 'favorites#destroy_vtuber'
    resources :comments, only: %i[create edit update destroy]
  end

  resource :user, only: %i[new create show] do
    delete 'favorite', to: 'favorites#destroy_user'
    get 'email', to: 'users#edit_email'
    patch 'email', to: 'users#update_email'
    get 'name', to: 'users#edit_name'
    patch 'name', to: 'users#update_name'
  end

  resources :password_resets, only: %i[new create edit update]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :pages, only: [] do
    collection do
      get :about
      get :terms
      get :privacy_policy
    end
  end
end