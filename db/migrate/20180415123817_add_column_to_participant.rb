class AddColumnToParticipant < ActiveRecord::Migration[5.1]
  def change
    add_column :participants, :sponsor, :boolean, default: false
  end
end
