Rails.application.routes.draw do
  root 'vtubers#index'

  # get "search", to: "searches#search"

  get 'show/:id', to: 'vtubers#show', as: :show

  post 'show/:id/favorite', to: 'favorites#create', as: :vtuber_favorite
  delete 'show/:id/favorite', to: 'favorites#destroy_vtuber'
  delete 'user/favorite/:id', to: 'favorites#destroy_user', as: :user_favorite

  post 'show/:id/comments', to: 'comments#create', as: :vtuber_comment
  get 'show/:id/comments', to: 'comments#edit', as: :vtuber_comment_edit
  patch 'show/:id/comments', to: 'comments#update', as: :vtuber_comment_update
  delete 'comments/:id', to: 'comments#destroy', as: :vtuber_comment_delete

  post '/', to: 'vtubers#name_input'

  get 'new', to: 'vtubers#new'
  post 'new', to: 'vtubers#create'

  get 'edit/:id', to: 'vtubers#edit', as: :edit
  patch 'edit/:id', to: 'vtubers#update'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'user/new', to: 'users#new'
  post 'user/new', to: 'users#create'

  get 'user', to: 'users#show'

  get 'user/email', to: 'users#edit_email'
  patch 'user/email', to: 'users#update_email'

  resources :password_resets, only: %i[new create edit update]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get 'user/name', to: 'users#edit_name'
  patch 'user/name', to: 'users#update_name'

  get 'pages/about', to: 'pages#about'
  get 'pages/terms', to: 'pages#terms'
  get 'pages/privacy_policy', to: 'pages#privacy_policy'
end