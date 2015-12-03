Rails.application.routes.draw do

  resources :posts
  resources :tag_strings

  get 'posts/index'

  root 'posts#index'
  
end
