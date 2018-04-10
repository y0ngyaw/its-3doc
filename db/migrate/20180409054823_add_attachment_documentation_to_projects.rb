class AddAttachmentDocumentationToProjects < ActiveRecord::Migration[5.1]
  def self.up
    change_table :projects do |t|
      t.attachment :documentation
    end
  end

  def self.down
    remove_attachment :projects, :documentation
  end
end 
