class SellsController < ApplicationController
  before_action :set_sell, only: [:show, :update, :destroy]
  before_action :authorize_request
  # GET /sells
  def index
    @sells = Sell.all

    render json: @sells
  end

  # GET /sells/1
  def show
    render json: @sell
  end

  # POST /sells
  def create
    @sell = Sell.new(sell_params)

    if @sell.save
      render json: @sell, status: :created
      
    else
      render json: @sell.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sells/1
  def update
    if @sell.update(sell_params)
      render json: @sell
    else
      render json: @sell.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sells/1
  def destroy
    @sell.destroy
  end

  def endpoint_ventas

    @sells = Sell.all
    
    @datos = @sells.collect{|sell| {"fecha de venta": "#{sell.fecha}","nombre o razon social del cliente": "#{(Client.find_by(id:sell.client_id)).nombre}","Monto Total": "#{sell.monto_total}"}}

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
      render json: @detalle
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
