class Client < ApplicationRecord
    has_many :reservations
    has_many :sells
end
