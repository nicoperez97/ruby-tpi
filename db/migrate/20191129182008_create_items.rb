class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :estado
      t.references :product, foreign_key: true
      t.references :reservation, foreign_key: true
      t.references :sell, foreign_key: true

      t.timestamps
    end
  end
end
