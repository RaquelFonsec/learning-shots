Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/search', to: 'search#index', as: :search

  resources :trails do
    resources :video_contents,only: [:new, :create]
  end
  resources :video_contents, only:[:show,:destroy]
end
