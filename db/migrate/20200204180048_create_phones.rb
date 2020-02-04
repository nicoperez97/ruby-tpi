class CreatePhones < ActiveRecord::Migration[5.1]
  def change
    create_table :phones do |t|
      t.bigint :number
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
