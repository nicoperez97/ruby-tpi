class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :estado
      t.references :product, foreign_key: true,null:false
      t.references :reservation, foreign_key: true,null:true
      t.references :sell, foreign_key: true,null:true

      t.timestamps
    end
  end
end
