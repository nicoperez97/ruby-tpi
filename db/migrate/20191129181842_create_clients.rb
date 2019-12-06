class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.integer :cuil
      t.string :nombre
      t.integer :condicion
      t.string :tel

      t.timestamps
    end
  end
end
