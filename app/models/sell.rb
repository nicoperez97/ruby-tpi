class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :reservation, optional:true
  has_many :sell_items

  def add_items(producto,cantidad)
    @product = Product.find_by(codigo:producto)
    if(@product.devolver_items(cantidad).nil?)
      {"#{@product.codigo}": "cantidad de items insuficientes"}
    else
      (@product.devolver_items(cantidad)).each{|item|
        item.reservado(self.id)
        SellItem.create(sell_id: self.id,item_id:item.id,item_precio:item.valor)}
        nil
    end
  end

  def monto_total
    @total=0
    self.sell_items.each{|sell_item|
      @total = @total + sell_item.valor}
    @total
  end
  def cancelar
    self.sell_items.each{|sell_item|sell_item.cancelar}
    self.sell_items.destroy_all
  end
  def add_items_reservation(reservation_items)
    reservation_items.each{ |reservation_item|
      item=Item.find_by(id:reservation_item.item_id)
      item.vendido(self.id)
      SellItem.create(sell_id:self.id,item_id:(reservation_item.item_id))}
  end
end
