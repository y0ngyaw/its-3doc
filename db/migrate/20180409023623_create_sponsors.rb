class CreateSponsors < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsors do |t|
      t.string :email
      t.string :password_digest
      t.boolean :admin
      t.string :remember_digest

      t.timestamps
    end
  end
end
