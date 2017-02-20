Rails.application.routes.draw do
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  resources :forums
  root to: "posts#index"
end
