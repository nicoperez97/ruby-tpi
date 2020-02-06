# README
TPI Ruby 2019

Heroku link:
    https://aqueous-lowlands-25904.herokuapp.com/


Endpoint a usar en la api:

    post 'usuarios' #Crea un usuario con el siguiente formato:

        {"us":"usuarios a resgistrar","password":"contraseña del usuario}
    
    post '/sesiones' #Inicia sesion de un usuario con el siguiente formato:

        {"u":"usuarios a loggear","p":"contraseña del usuario}

    #Enpoints de Productos

    post 'productos' #Crea un producto con el siguiente formato:

        {"codigo":"codigo deseado para el producto","descripcion":"descripcion deseada","detalle":"detalle deseado","montoU":"monto unitario deseado"}

    get 'productos' #Mostrar todos los productos 

    get 'productos/:codigo' #Mostrar un producto determinad

    get 'productos/:codigo/items' #Mostrar los items de un producto determinado

    post 'productos/:codigo/items' #Agregarle items a un producto determina mediante la variable "cantidad" con el siguiente formato:

        {"cantidad":"cantidad de items deseados a agregar a dicho producto"}

    #Enpoints de Reservas

    get '/reservas' #Mostrar todas las reservas

    post '/reservas' #Crear una reserva con el siguiente formato:

        {
        "productos": {
            "codigo del producto": "cantidad de items de dicho producto",
            "codigo del producto": "cantidad de items de dicho producto"
        },
        "cliente_id":"id del cliente"
        }

    get '/reservas/:id' #Mostrar una reserva determinada

    put '/reservas/:id/vender' #Pasar una reserva determinada a venta

    delete '/reservas/:id' #Eliminar una reserva determinada

    #Endpoint de Ventas

    get '/ventas' #Mostrar todas las ventas del usuario loggeado

    get '/ventas/:id' #Mostrar una venta determinada del usuario loggeado

    post '/ventas' #Crear una venta con el siguiente formato:

        {
        "productos": {
            "codigo del producto": "cantidad de items de dicho producto",
            "codigo del producto": "cantidad de items de dicho producto"
        },
        "cliente_id":"id del cliente"
        }

    delete '/ventas/:id' #Eliminar una venta determinada si la hizo le usuario loggeado

    #Endpoint de Cliente

    post '/cliente/:cuil/add_phone' #Agrega un numero a un cliente determinado con el siguiente formato:

        {"phone":"numero deseado a agregar"}

    post '/cliente' #Crea un cliente con el siguiente formato:

        {"cuil":"cuil deseado","nombre":"nombre deseado","condicion":"iva deseado","email":"mail deseado"}

    get '/cliente', to:  #Muestra todos los clientes
