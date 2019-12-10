class Product < ApplicationRecord
    has_many :items

    def get_product_by_cod(cod)
        return (Product.all.map {|p| p.codigo = cod}.uniq)
    end


    #select de ruby, en vez de where
    #and, no es and de la base de datos
    
    def self.in_stock(cantmax)
        #self.order(:id).where(self.items_disponibles.count()>0).limit(cantmax)   
    end

    def self.scarce(cantmax)
        #self.order(:id).where((self.items_disponibles.count()>0) and (self.items_disponibles.count()<5)).limit(cantmax)   
    end        

    def self.todos(cantmax)
        self.order(:id).limit(cantmax)   
    end    


    def items_disponibles
        self.order(:id).where(self.items.state == "disponible")
    end
end
