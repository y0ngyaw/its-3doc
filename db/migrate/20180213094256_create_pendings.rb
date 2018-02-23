class CreatePendings < ActiveRecord::Migration[5.1]
  def change
    create_table :pendings do |t|
      t.references :participant, foreign_key: true
      t.references :proposal, foreign_key: true

      t.timestamps
    end
  end
end
