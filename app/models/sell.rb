class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :reservation, optional:true
  has_many :items

  def monto_total
    @total=0
    self.items.each{|item|@total = @total + (Product.find_by(id:item.product_id)).montoU}
    @total
  end
end
