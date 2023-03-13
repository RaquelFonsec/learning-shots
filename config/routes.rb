Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post '/search', to: 'search#index', as: :search

  resources :trails do
    resources :video_contents,only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end
  resources :video_contents, only:[:show,:destroy]
end
