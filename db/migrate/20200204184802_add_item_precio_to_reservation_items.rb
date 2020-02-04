class AddItemPrecioToReservationItems < ActiveRecord::Migration[5.1]
  def change
    add_column :reservation_items, :item_precio, :bigint
  end
end
