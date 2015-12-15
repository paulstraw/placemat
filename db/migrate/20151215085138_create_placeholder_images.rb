class CreatePlaceholderImages < ActiveRecord::Migration
  def change
    create_table :placeholder_images do |t|
      t.integer :native_width, null: false, index: true
      t.integer :native_height, null: false, index: true
      t.integer :image_category, index: true

      t.timestamps null: false
    end
  end
end
