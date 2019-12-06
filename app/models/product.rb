class Product < ApplicationRecord
    has_many :item

    def get_product_by_cod(cod)
        return (Product.all.map {|p| p.codigo = cod}.uniq)


end
