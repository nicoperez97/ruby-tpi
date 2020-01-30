class CreateSellItems < ActiveRecord::Migration[5.1]
  def change
    create_table :sell_items do |t|
      t.references :sell, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
