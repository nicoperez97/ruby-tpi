Rails.application.routes.draw do
  post 'usuarios', to: 'users#create'
  
  resources :users, param: :_username
  post '/sesiones', to: 'authentication#login'
  get '/*a', to: 'application#not_found'


  #post 'sesiones', to: 'authentication#login'
  #resources :products, only: [:index, :show], as: :productos, path: "productos" do
  #  resources :items, only: [:index, :create]
  #end
  #resources :reservations, except: :update, as: :reservas, path: "reservas"
  #put 'reservas/:id/vender', to: 'reservations#sell'
  #resources :sells, except: [:update, :destroy], as: :ventas, path: "ventas"

  #get "/productos/:codigo", to: "user#get_product_by_cod(:codigo)"



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
 