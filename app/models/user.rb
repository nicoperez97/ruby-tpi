class User < ApplicationRecord
    has_many :reservation
    has_many :sell

    def create
    end
end
