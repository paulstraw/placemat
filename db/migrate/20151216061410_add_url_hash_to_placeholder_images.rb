class AddUrlHashToPlaceholderImages < ActiveRecord::Migration
  def change
    add_column :placeholder_images, :url_hash, :string
  end
end
