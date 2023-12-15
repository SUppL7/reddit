Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts

  mount Commontator::Engine => '/commontator'

  post '/comments/:id/reply', to: 'comments#reply', as: 'reply_to_comment'


end
