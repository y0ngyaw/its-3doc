class ChangeAdminColumnInSponsorCorrection < ActiveRecord::Migration[5.1]
  def change
  	change_column :sponsors, :admin, :boolean, default: false
  end
end
