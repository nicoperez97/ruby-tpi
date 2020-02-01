class ReservationItem < ApplicationRecord
  belongs_to :reservation
  belongs_to :item

  def valor
    self.item.valor
  end
  
  def cancelar
    self.item.disponible
  end

end
