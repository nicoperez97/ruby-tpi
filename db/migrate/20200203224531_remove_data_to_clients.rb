class RemoveDataToClients < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients,  :cuil
  end
end
