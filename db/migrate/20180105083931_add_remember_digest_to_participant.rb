class AddRememberDigestToParticipant < ActiveRecord::Migration[5.1]
  def change
    add_column :participants, :remember_digest, :string
  end
end
