class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :codigo
      t.string :descripcion
      t.string :detalle
      t.integer :montoU

      t.timestamps
    end
  end
end
