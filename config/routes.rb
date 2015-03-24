Rails.application.routes.draw do

  devise_for :users
  root 'members#index'
  
  resources :articles
  resources :members do
    get 'tree', on: :member
    get 'big_tree', on: :collection
    resources :connections, only: [:index, :create, :destroy, :new]
  end
 
end
