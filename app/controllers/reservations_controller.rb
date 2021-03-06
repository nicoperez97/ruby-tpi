class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :authorize_request
 
  def endpoint_own_items
    @id = params[:id]
    @reservation = Reservation.find(@id)
    render json: @reservation, serializer:ReservationSerializer 
  end


  def endpoint_eliminar
    @id = params[:id]
    @reservation=Reservation.find(@id)
    if(!Sell.find_by(reservation_id:@reservation.id))
      @reservation.cancelar
      @reservation.destroy
      render :status => 200
    else
      render :status => 404
    end
  end

  def endpoint_reservas_id
    @id = params[:id]

    @reservation = Reservation.find_by(id:@id)
    if @reservation.nil?
      render :status => 404
    else
      render json: @reservation, serializer:ReservationSerializer
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
    @user_id = @current_user.id
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
      @reservation.destroy
      render json: @detalle ,:status => 404
    end
  end

  def endpoint_vender
    @id = params[:id]
    @reservation = Reservation.find_by(id:@id)
    if (!Sell.find_by(reservation_id:@reservation.id))
      @sell = Sell.create(fecha:Time.now,client_id:@reservation.client_id,user_id:@current_user.id,reservation_id:@reservation.id)
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