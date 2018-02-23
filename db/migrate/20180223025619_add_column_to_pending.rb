class AddColumnToPending < ActiveRecord::Migration[5.1]
  def change
    add_column :pendings, :status, :string, default: "pending"
  end
end
