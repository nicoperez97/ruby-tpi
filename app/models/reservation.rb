class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :reservation_items

  def add_items(producto,cantidad)
    @product = Product.find_by(codigo:producto)
    if(@product.devolver_items(cantidad).nil?)
      {"#{@product.codigo}": "cantidad de items insuficientes"}
    else
      (@product.devolver_items(cantidad)).each{|item|
        item.reservado(self.id)
        ReservationItem.create(reservation_id: self.id,item_id:item.id)}
        nil
    end
  end
  
  def monto_total
    @total=0
    self.reservation_items.each{|reservation_item|
      @total = @total + reservation_item.valor}
    @total
  end

  def sell_items(sell_id)
    @sell = Sell.find(sell_id)
    @sell.add_items_reservation(self.reservation_items)
  end

  def cancelar
      self.reservation_items.each{|reservation_item|reservation_item.cancelar}
      self.reservation_items.destroy_all
  end

  def own_items
    @items = {}
    self.reservation_items.each{|ri|@items.merge!({"#{ri.item_id}": {"estado": "#{ri.item.estado}","product_id": "#{ri.item.product_id}","reservation_id": "#{ri.item.reservation_id}","sell_id": "#{ri.item.sell_id}","created_at": "#{ri.item.created_at}","updated_at": "#{ri.item.updated_at}"}})}
    @items
  end
end
