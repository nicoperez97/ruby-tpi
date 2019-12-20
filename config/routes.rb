Rails.application.routes.draw do
  post 'usuarios', to: 'users#create'
  
  resources :users, param: :_username
  post '/sesiones', to: 'authentication#login'
  
  get 'productos', to: 'products#endpoint_productos'
  
  get 'productos/:codigo', to: 'products#endpoint_productos_codigo'
  
  
  
  
  #Siempre va abajo
  get '/*a', to: 'application#not_found'

  




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
 