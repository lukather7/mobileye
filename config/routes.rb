Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get     'admin', to: 'admin#index'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get 'ordershow'
    end
  end
  resources :microposts do
    member do
      get 'do_map'
    end
  end
  get 'carids/allmap', to: "carids#allmap",  as: 'allmap'
  
  get 'carids/order', to: "carids#ordered",  as: 'ordered_carids'
  resources :carids do
    member do
      get 'carte'
    end
  end
end
