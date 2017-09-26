Rails.application.routes.draw do
  root to: 'static_pages#home'
#  get    'signup', to: 'users#new'
  get     'admin', to: 'admin#index'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :microposts
  resources :carids
end
