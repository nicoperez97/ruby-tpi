class Item < ApplicationRecord
  belongs_to :product
  belongs_to :reservation, optional:true
  belongs_to :sell, optional:true
  #poner en la migracion columna Null:true

  def reservado(reservation_id)
    self.estado = "reservado"
    self.reservation_id = reservation_id
    self.save
  end

  def disponible
    self.estado = "disponible"
    self.save
  end

  def vendido(sell_id)
    self.estado = "vendido"
    self.sell_id = sell_id
  end
  def valor
    self.product.montoU
  end
end
