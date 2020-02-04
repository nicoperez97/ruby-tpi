class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]
  before_action :authorize_request

  # GET /clients
  def index
    @clients = Client.all

    render json: @clients , each_serializer:ClientSerializer
  end

  # GET /clients/1
  def show
    render json: @client.phones
  end

  # POST /clients

  def create
    @client = Client.new(client_params)
    if @client.save
      render json: @client, serilizer:ClientSerializer,status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  def endpoint_add_phone
    if @client = Client.find_by(cuil:params[:cuil])
      @client.add_phones(params[:phone])
      render json: @client, serilizer:ClientSerializer
    else
      render :status => 404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.require(:client).permit(:cuil, :nombre, :condicion, :email)
    end
end
