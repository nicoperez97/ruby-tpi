class Item < ApplicationRecord
  belongs_to :product
  belongs_to :reservation
  belongs_to :sell
end
