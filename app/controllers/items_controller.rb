class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :authorize_request
  

  def item_create_for_product
    @arr = Array.new()
    @codigo = params[:codigo]
    @product = Product.find_by(codigo: @codigo)
    if(@product.nil?)
       render :status => 404
    else
       if((params[:cantidad].to_i) > 0)
          params[:cantidad].to_i.times {
          @item = Item.new(product_id: @product.id, estado: 'disponible')
          @item.save
          @arr.push(@item)
          }
          
          render json:@arr  
      else
          render :status => 404
      end
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
