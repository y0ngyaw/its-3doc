class AddColumnToSponsorVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :sponsor_votes, :sponsor_id, :integer
  end
end
