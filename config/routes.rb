Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post 'search', to: 'search#search', as: 'search'
  get 'my_trails', to: 'trails#my_trails', as: 'my_trails'


  resources :trails do
    resources :video_contents,only: [:new, :create]
    resources :reviews, only: [:new, :create]
    resources :meetings, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :video_contents, only:[:show,:destroy]
  resources :meetings, only: :index
end
