class CreateSponsorVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsor_votes do |t|
      t.integer :first_place
      t.integer :second_place
      t.integer :third_place
      t.integer :fourth_place
      t.integer :fifth_place

      t.timestamps
    end
  end
end
