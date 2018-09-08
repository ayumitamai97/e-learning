Rails.application.routes.draw do
  root "categories#index"

  devise_for :users
  resources :users, only: [:index, :show]
  resources :lessons
  resources :words
  resources :categories

  namespace :admin do
    root "categories#index"

    devise_for :users
    resources :users, only: [:index, :edit, :update, :destroy] do
      resources :lessons
    end

    resources :categories
    resources :words

    # resourcesで指定しても以下が設定されない
    patch "/categories", to: "categories#update"
    patch "/words", to: "words#update"
  end
end
