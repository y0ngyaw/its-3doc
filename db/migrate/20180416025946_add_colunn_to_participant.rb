class AddColunnToParticipant < ActiveRecord::Migration[5.1]
  def change
    add_column :participants, :vote, :boolean, default: true
  end
end
