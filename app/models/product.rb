class Product < ApplicationRecord
    has_many :items

    #def get_product_by_cod(cod)
    #    return (Product.all.map {|p| p.codigo = cod}.uniq)
    #end


    #select de ruby, en vez de where
    #and, no es and de la base de datos
    
    def self.in_stock
        self.order(:id).limit(25).select {|p| p.items_disponibles.count()>0}
    end

    def self.scarce
        self.order(:id).limit(25).select{|p| (p.items_disponibles.count()>0) and (p.items_disponibles.count()<5)}
    end        

    def self.todos
        self.order(:id).limit(25)
    end    


    def items_disponibles
        self.order(:id).select{|p|p.items.state == "disponible"}
    end
end
