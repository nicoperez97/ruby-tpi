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
            
        end
    end  
end 

