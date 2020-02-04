class SellsController < ApplicationController
  before_action :set_sell, only: [:show, :update, :destroy]
  before_action :authorize_request
  

  def endpoint_ventas
    @sells = Sell.all
    @datos = @sells.select{|sell|sell.user_id==@current_user.id}.collect{|sell| {"fecha de venta": "#{sell.fecha}","nombre o razon social del cliente": "#{(Client.find_by(id:sell.client_id)).nombre}","Monto Total": "#{sell.monto_total}"}}
    render json: @datos
  end

  def endpoint_post_ventas
    @productos = params[:productos]
    @cliente_id = params[:cliente_id]
    @user_id = @current_user.id
    @sell = Sell.create!(client_id:@cliente_id,user_id:@user_id, fecha: Time.now) 
    @detalle = {}
    @productos.each do |producto, cantidad|
      @var=(@sell.add_items(producto,cantidad))
      if !@var.nil?
        @detalle.merge!(@var)
      end
    end
    if @detalle.empty?
      render json: @sell
    else
      @sell.cancelar
      @sell.destroy
      render json: @detalle, :status => 404
    end
  end

  def endpoint_ventas_id
    @id = params[:id]
    @Sell = Sell.find_by(id:@id)
    if(@current_user.id == @Sell.user_id)
      if @Sell.nil?
        render :status => 404
      else
        render json:@Sell, serializer:SellSerializer
      end
    else
      render :status => 404
    end
  end

  def endpoint_eliminar
    @id = params[:id]
    @sell=Sell.find(@id)
    if(@current_user.id == @sell.user_id)
      @sell.cancelar
      @sell.destroy
      render :status => 200
    else
      render :status => 404
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sell
      @sell = Sell.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sell_params
      params.require(:sell).permit(:fecha, :client_id, :user_id, :reservation_id)
    end
end
