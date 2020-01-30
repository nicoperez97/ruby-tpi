class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :reservation_items

  def add_items(producto,cantidad)
    @product = Product.find_by(codigo:producto)
    (@product.devolver_items(cantidad)).each{|item|
      item.reservado(self.id)
      ReservationItem.create(reservation_id: self.id,item_id:item.id)}
  end
  def monto_total
    @total=0
    self.reservation_items.each{|reservation_item|
      @total = @total + reservation_item.valor}
    @total
  end
end
