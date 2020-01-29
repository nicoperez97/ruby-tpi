class Item < ApplicationRecord
  belongs_to :product
  belongs_to :reservation, optional:true
  belongs_to :sell, optional:true
  #poner en la migracion columna Null:true

  def reservado
    self.estado = "reservado"
  end

  def disponible
    self.estado = "disponible"
  end

  def vendido
    self.estado = "vendido"
  end
end
