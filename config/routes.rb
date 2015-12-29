Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root "top#index"

  #lecturesへのroutes
  resources :lectures, only: [:index, :show, :new, :create]

  #studentへのroutes
  resources :students, only: [:index, :show, :new, :create] do
    resources :lectures_students, only: [:new, :create]
  end
end
