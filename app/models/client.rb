class Client < ApplicationRecord
    has_many :reservations
    has_many :sells
    has_many :phones

    validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    presence: true

    validates :cuil, 
    format: { with: /\b(20|23|24|27|30|33|34)(\D)?[0-9]{8}(\D)?[0-9]/ ,
               message: "must contain valid cuit|cuil"},
    presence: true, 
    uniqueness: true, 
    length: {is: 11}

    validates :nombre,
    format: { with: /\A[a-zA-Z.']+(?:\s[a-zA-Z.']+)*\s?\z/, message: "must contain only letters"}
    
    def add_phones(num)
        @phone=Phone.create!(number:num,client_id:self.id)
        self
    end
end
