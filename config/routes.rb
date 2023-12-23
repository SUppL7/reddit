Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'posts#index'

  resources :posts do
    resources :comments, only: [:create, :edit, :destroy]
  end
end
