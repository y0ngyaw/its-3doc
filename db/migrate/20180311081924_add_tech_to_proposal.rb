class AddTechToProposal < ActiveRecord::Migration[5.1]
  def change
    add_column :proposals, :tech, :string, limit: 30
  end
end
