Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  resources :forums
  root to: "posts#index"
end
