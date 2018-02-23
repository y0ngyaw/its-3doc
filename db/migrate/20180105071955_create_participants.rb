class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone_num

      t.timestamps
    end
  end
end
