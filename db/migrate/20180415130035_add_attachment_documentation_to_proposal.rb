class AddAttachmentDocumentationToProposal < ActiveRecord::Migration[5.1]
  def self.up
    change_table :proposals do |t|
      t.attachment :documentation
    end
  end

  def self.down
    remove_attachment :proposals, :documentation
  end
end
