class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  # GET /reservations
  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  # GET /reservations/1
  def show
    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end


  def endpoint_eliminar
    @id = params[:id]
    @reservation=Reservation.find(@id)
    if(!Sell.find_by(reservation_id:@reservation.id))
      @reservation.cancelar
      @reservation.destroy
      render :status => 200
    end
  end

  def endpoint_reservas_id
    @id = params[:id]

    @reservations = Reservation.find_by(id:@id)
    if @reservations.nil?
      render :status => 404
    else
      render json: @reservations
    end
  end
  
  def endpoint_reservas

    @reservations = Reservation.all.select{|reserva| !Sell.find_by(reservation_id:reserva.id)}
    
    @datos = @reservations.collect{|reserva| {"fecha de reserva": "#{reserva.fecha}","nombre o razon social del cliente": "#{(Client.find_by(id:reserva.client_id)).nombre}","Monto Total": "#{reserva.monto_total}"}}

    render json: @datos
  end
  
  def endpoint_post_reservas
    @productos = params[:productos]
    @cliente_id = params[:cliente_id]
    @user_id = params[:user_id]
    @reservation = Reservation.create!(client_id:@cliente_id,user_id:@user_id, fecha: Time.now) 
    @detalle = {}
    @productos.each do |producto, cantidad|
      @var=(@reservation.add_items(producto,cantidad))
      if !@var.nil?
        @detalle.merge!(@var)
      end
    end
    if @detalle.empty?
      render json: @reservation
    else
      @reservation.cancelar
      render json: @detalle
    end
  end

  def endpoint_vender
    @id = params[:id]
    @reservation = Reservation.find_by(id:@id)
    if (!Sell.find_by(reservation_id:@reservation.id))
      @sell = Sell.create(fecha:Time.now,client_id:@reservation.client_id,user_id:@reservation.user_id,reservation_id:@reservation.id)
      @reservation.sell_items(@sell.id)
      render json: @sell
    else
      render :status => 404
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.require(:reservation).permit(:fecha, :client_id, :user_id)
    end
end