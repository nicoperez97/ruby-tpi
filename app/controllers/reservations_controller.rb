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

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end

  def endpoint_reservas
    @reservations = Reservation.all

    render json: @reservations
  end

  def endpoint_post_reservas
    @productos = params[:productos]
    @cliente_id = params[:cliente_id]
    @user_id = params[:user_id]
    @reservation = Reservation.create!(client_id:@cliente_id,user_id:@user_id, fecha: Time.now) 
    @productos.each do |producto, cantidad|
      @reservation.add_items(producto,cantidad)
    end 
    render json: @reservation
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
