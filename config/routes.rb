Rails.application.routes.draw do
  root "categories#index"

  devise_for :users
  resources :users
  resources :lessons
  resources :words
  resources :categories

  namespace :admin do
    root "categories#index"

    devise_for :users
    resources :users
    resources :categories
    resources :words
    resources :lessons
  end
end
