class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :tech
      t.integer :theme

      t.timestamps
    end
  end
end
