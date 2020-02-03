Rails.application.routes.draw do
  post 'usuarios', to: 'users#create'
  
  resources :users, param: :_username
  
  post '/sesiones', to: 'authentication#login'
  
  #Enpoints de Productos
  
  get 'productos', to: 'products#endpoint_productos' #Mostrar todos los productos 
  
  get 'productos/:codigo', to: 'products#endpoint_productos_codigo' #Mostrar un producto determinad
  
  get 'productos/:codigo/items', to: 'products#endpoint_productos_codigo_items' #Mostrar los items de un producto determinado
   
  post 'productos/:codigo/items', to: 'items#item_create_for_product' #Agregarle items a un producto determina mediante la variable "cantidad"
  
  #Enpoints de Reservas
  
  get '/reservas' , to: 'reservations#endpoint_reservas' #Mostrar todas las reservas

  post '/reservas' , to: 'reservations#endpoint_post_reservas'  #Crear una reserva

  get '/reservas/:id', to: 'reservations#endpoint_reservas_id' #Mostrar una reserva determinada

  put '/reservas/:id/vender', to: 'reservations#endpoint_vender' #Pasar una reserva determinada a venta

  delete '/reservas/:id', to: 'reservations#endpoint_eliminar' #Eliminar una reserva determinada
  
  #Endpoint de Ventas
  
  get '/ventas', to: 'sells#endpoint_ventas' #Mostrar todas las ventas del usuario loggeado

  get '/ventas/:id', to: 'sells#endpoint_ventas_id' #Mostrar una venta determinada del usuario loggeado

  post '/ventas', to: 'sells#endpoint_post_ventas' #Crear una venta

  


  #Siempre va abajo
  get '/*a', to: 'application#not_found'

  




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
 