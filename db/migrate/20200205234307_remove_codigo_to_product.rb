class RemoveCodigoToProduct < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :codigo
  end
end
