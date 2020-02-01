Rails.application.routes.draw do
  post 'usuarios', to: 'users#create'
  
  resources :users, param: :_username
  post '/sesiones', to: 'authentication#login'
  
  get 'productos', to: 'products#endpoint_productos'
  
  get 'productos/:codigo', to: 'products#endpoint_productos_codigo'
  
  get 'productos/:codigo/items', to: 'products#endpoint_productos_codigo_items'
   
  post 'productos/:codigo/items', to: 'items#item_create_for_product'
  
  get '/reservas' , to: 'reservations#endpoint_reservas'

  post '/reservas' , to: 'reservations#endpoint_post_reservas'

  get '/reservas/:id', to: 'reservations#endpoint_reservas_id' #falta compound document

  get '/ventas', to: 'sells#endpoint_ventas'

  get '/ventas/:id', to: 'sells#endpoint_ventas_id'#falta resolver lo del current_user

  post '/ventas', to: 'sells#endpoint_post_ventas'

  put '/reservas/:id/vender', to: 'reservations#endpoint_vender'

  delete '/reservas/:id', to: 'reservations#endpoint_eliminar'#falta hacer

  
  
  get '/all_ventas', to: 'sells#index'

  get '/all_reservas', to: 'reservations#index'

  post '/cliente', to: 'clients#create'

  post 'productos/create', to: 'products#create'

  post 'items/create', to: 'items#create'
  
  get '/items', to: 'items#index'

  get '/revervas_items', to: 'reservation_items#index'
  #Siempre va abajo
  get '/*a', to: 'application#not_found'

  




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
 