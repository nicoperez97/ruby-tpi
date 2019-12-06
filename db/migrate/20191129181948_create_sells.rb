class CreateSells < ActiveRecord::Migration[5.1]
  def change
    create_table :sells do |t|
      t.date :fecha
      t.references :client, foreign_key: true
      t.references :user, foreign_key: true
      t.references :reservation, foreign_key: true

      t.timestamps
    end
  end
end
