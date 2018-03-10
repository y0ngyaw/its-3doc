class ChangeTitleAndDescriptionLengthInProposals < ActiveRecord::Migration[5.1]
  def self.up 
  	change_column :proposals, :title, :string, limit: 65, null: false 
  	change_column :proposals, :description, :string, limit: 255, null: false 
  end

  def self.down
  	change_column :proposals, :title, :string
  	change_column :proposals, :description, :string
  end 
end
