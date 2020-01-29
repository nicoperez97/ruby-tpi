class CreateReservationItems < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_items do |t|
      t.references :reservation, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
