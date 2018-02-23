class AddColumnToTeamMember < ActiveRecord::Migration[5.1]
  def change
    add_column :team_members, :status, :string, default: "active"
  end
end
