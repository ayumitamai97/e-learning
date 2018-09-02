Rails.application.routes.draw do
  resources :lessons
  resources :words
  resources :categories
  devise_for :users
  resources :users
  root "users#index"
end
