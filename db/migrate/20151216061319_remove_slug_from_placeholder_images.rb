class RemoveSlugFromPlaceholderImages < ActiveRecord::Migration
  def change
    remove_column :placeholder_images, :slug, :string
  end
end
