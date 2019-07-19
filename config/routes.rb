Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/show'
  resources :pictures do
    collection do
     post :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
