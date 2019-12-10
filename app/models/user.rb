class User < ApplicationRecord
    has_many :reservations
    has_many :sells
    
    has_secure_password
    validates :us, presence: true, uniqueness: true
    validates :password,
                length: { minimum: 6 },
                if: -> { new_record? || !pass.nil? }

end
