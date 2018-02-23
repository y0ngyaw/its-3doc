class AddDefaultValueToStatusAttribute < ActiveRecord::Migration[5.1]
  def change
  	change_column :proposals, :status, :boolean, default: true
  end
end
