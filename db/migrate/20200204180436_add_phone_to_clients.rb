class AddPhoneToClients < ActiveRecord::Migration[5.1]
  def change
    add_reference :clients, :phone, foreign_key: true
  end
end
