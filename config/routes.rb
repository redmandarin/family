Rails.application.routes.draw do

  devise_for :users
  root 'members#index'
  
  resources :articles
  resources :members do
    member do 
      get 'tree'
      get 'big_tree'
    end
    resources :connections, only: [:index, :create, :destroy, :new]
  end
 
end
