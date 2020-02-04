class RemoveTelToClients < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :tel
  end
end
