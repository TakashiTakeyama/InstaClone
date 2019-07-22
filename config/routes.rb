Rails.application.routes.draw do
  root to:'sessions#new'
  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :pictures do
    collection do
     post :confirm
      get :okiniiri
    end
  end
  resources :favorites, only: %i[create destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
