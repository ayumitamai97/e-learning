Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/new'
    get 'users/create'
    get 'users/edit'
    get 'users/update'
    get 'users/destroy'
    get 'users/show'
  end
  root "categories#index"

  devise_for :users
  resources :users
  resources :lessons
  resources :words
  resources :categories

  namespace :admin do
    devise_for :users
    resources :users
    resources :categories
    resources :words
    resources :lessons
  end
end
