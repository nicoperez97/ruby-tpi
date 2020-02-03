class AddCuilToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :cuil, :bigint
  end
end
