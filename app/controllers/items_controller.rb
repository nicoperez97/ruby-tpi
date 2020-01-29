class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    @items = Item.all

    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  def item_create_for_product
    @arr = Array.new()
    @codigo = params[:codigo]
    @product = Product.find_by(codigo: @codigo)
    if(@product.nil?)
       render :status => 404
    else
       if((params[:cant].to_i) > 0)
          params[:cant].to_i.times {
          @item = Item.new(product_id: @product.id, estado: 'disponible')
          @item.save
          @arr.push(@item)
          }
       end
       render json:@arr
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:estado, :product_id, :reservation_id, :sell_id)
    end
end
