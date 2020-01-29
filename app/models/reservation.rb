class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :reservation_items

  def add_items(producto,cantidad)
    @product = Product.find_by(codigo:producto)
    (@product.devolver_items(cantidad)).each{|item|
      item.reservado
      ReservationItem.new(reservation_id: self.id,item_id:item.id)}
  end
end
