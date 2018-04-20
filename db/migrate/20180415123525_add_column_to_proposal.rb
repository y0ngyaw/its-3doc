class AddColumnToProposal < ActiveRecord::Migration[5.1]
  def change
    add_column :proposals, :top5, :boolean, default: false
  end
end
