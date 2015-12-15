class AddSlugToPlaceholderImages < ActiveRecord::Migration
  def change
    add_column :placeholder_images, :slug, :string
  end
end
