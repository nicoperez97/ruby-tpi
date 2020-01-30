Rails.application.routes.draw do
  post 'usuarios', to: 'users#create'
  
  resources :users, param: :_username
  post '/sesiones', to: 'authentication#login'

  post 'productos/create', to: 'products#create'

  post 'items/create', to: 'items#create'
  
  get '/items', to: 'items#index'
  
  get 'productos', to: 'products#endpoint_productos'
  
  get 'productos/:codigo', to: 'products#endpoint_productos_codigo'
  
  get 'productos/:codigo/items', to: 'products#endpoint_productos_codigo_items'
   
  post 'productos/:codigo/items', to: 'items#item_create_for_product'
  
  get '/reservas' , to: 'reservations#endpoint_reservas'

  post '/reservas' , to: 'reservations#endpoint_post_reservas' #falta borrar la reserva cuando no se puede

  get '/reservas/:id', to: 'reservations#endpoint_reservas_id' #falta compound document
  
  post '/cliente', to: 'clients#create'

  get '/ventas', to: 'sells#index'

  post '/ventas', to: 'sells#create'

  #Siempre va abajo
  get '/*a', to: 'application#not_found'

  




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
 