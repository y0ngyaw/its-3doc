class AddColumnSpmarksToProposal < ActiveRecord::Migration[5.1]
  def change
    add_column :proposals, :sp_marks, :integer, default: 0
  end
end
