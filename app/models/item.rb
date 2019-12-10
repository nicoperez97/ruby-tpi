class Item < ApplicationRecord
  belongs_to :product
  belongs_to :reservation, optional:true
  belongs_to :sell, optional:true
  #poner en la migracion columna Null:true
end
