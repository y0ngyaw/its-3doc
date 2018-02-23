class AddThemeToProposals < ActiveRecord::Migration[5.1]
  def change
    add_column :proposals, :theme, :integer, default: 1
  end
end
