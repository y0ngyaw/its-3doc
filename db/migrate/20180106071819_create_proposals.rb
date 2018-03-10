class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.string :title, limit: 65
      t.string :description, limit: 255
      t.boolean :status
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
