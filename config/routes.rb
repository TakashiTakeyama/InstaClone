Rails.application.routes.draw do
  get 'new/create'
  get 'new/show'
  resources :pictures do
    collection do
     post :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
