class CreateTeamMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_members do |t|
      t.references :proposal, foreign_key: true
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
