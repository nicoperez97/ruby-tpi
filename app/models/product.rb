class Product < ApplicationRecord
    has_many :items

    #select de ruby, en vez de where
    #and, no es and de la base de datos
    
    validates :codigo, format: { with: /\A(?=(?:.*\d){6})(?=(?:.*[a-zA-Z]){3})^[a-zA-Z\d]*$\z/ , message: "must be contain 3 letters and 6 digits"}, length: { is: 9 },presence:true,uniqueness:true
    validates :descripcion, length: { maximum: 200 }

    validates_presence_of :detalle, :descripcion, :montoU
    
    def self.in_stock
        self.order(:id).limit(25).select {|p| p.items_disponibles.count()>0}
    end

    def self.scarce
        self.order(:id).limit(25).select{|p| (p.items_disponibles.count()>0) and (p.items_disponibles.count()<6)}
    end        

    def self.todos
        self.order(:id).limit(25)
    end    

    def items_disponibles
        self.items.select{|i|i.estado == "disponible"}
    end
    def existe(cod)
        self.find_by(codigo: cod)
    end 
    def devolver_items(cantidad)
        if (self.items_disponibles.count() >= cantidad.to_i)
            self.items.select{|item|item.estado == "disponible"}.first(cantidad.to_i)
        else
            nil
        end
    end  
end 

