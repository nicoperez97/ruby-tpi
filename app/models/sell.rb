class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :reservation, option:true
  has_many :items
end
