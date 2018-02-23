class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.string :title
      t.string :description
      t.boolean :status
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
