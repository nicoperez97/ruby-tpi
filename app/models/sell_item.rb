class SellItem < ApplicationRecord
  belongs_to :sell
  belongs_to :item

  def valor
    self.item.valor
  end
end
