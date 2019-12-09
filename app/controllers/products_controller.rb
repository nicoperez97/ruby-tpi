class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :authorize_request
  # GET /products
  def index
    @products = Product.all
    
    cantmax = 25
    @filtro = params[:filter]
    case filtro
    when 'in_stock'
      @product = Product.in_stock(cantmax)
    when 'scarce'
      @product = Product.scarce(cantmax)
    when 'all'      
      @product = Product.all(cantmax)
    else
      @product = Product.in_stock(cantmax)


    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:codigo, :descripcion, :detalle, :montoU)
    end
end
