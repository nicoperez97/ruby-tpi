class Client < ApplicationRecord
    has_many :reservation
    has_many :sell
end
