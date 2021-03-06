class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :authorize_request
  
  
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  
  # GET /products
  def endpoint_productos
    
    @filtro = params[:filter]
    
    #throw @filtro
    
    # http://localhost:3000/productos/?filter=all(aca va el parametro a buscar)

    @product =( case @filtro
              when 'scarce'
                Product.scarce
              when 'all'      
                Product.todos
              else
                Product.in_stock
              end)

    

    render json: @product
  end

  def endpoint_productos_codigo
    @codigo = params[:codigo]
    @product = Product.find_by(codigo:  @codigo)
    if (@product.nil?)
      render :status => 404
    else 
      render json: @product
    end
  end

  def endpoint_productos_codigo_items
    @codigo = params[:codigo]
    @product = Product.find_by(codigo:  @codigo)
    if (@product.nil?)
      render :status => 404
    else 
      items_estado = @product.items.collect{|item| {"id": "#{item.id}", "estado": "#{item.estado}", "montoU": "#{@product.montoU}"}}
      render json: items_estado 
    end
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
