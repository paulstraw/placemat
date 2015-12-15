class AddAttachmentImageToPlaceholderImages < ActiveRecord::Migration
  def self.up
    change_table :placeholder_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :placeholder_images, :image
  end
end
