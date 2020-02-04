class AddItemPrecioToSellItems < ActiveRecord::Migration[5.1]
  def change
    add_column :sell_items, :item_precio, :bigint
  end
end
