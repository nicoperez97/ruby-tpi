class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :items
end
