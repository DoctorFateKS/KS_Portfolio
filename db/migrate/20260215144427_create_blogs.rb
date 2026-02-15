class CreateBlogs < ActiveRecord::Migration[8.0]
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.text :excerpt, null: false
      t.text :content, null: false
      t.string :category, null: false, default: 'Other'
      t.string :tags
      t.boolean :published, default: false
      t.integer :view_count, default: 0

      t.timestamps
    end

    add_index :blogs, :title, unique: true
    add_index :blogs, :category
    add_index :blogs, :published
    add_index :blogs, :created_at
  end
end
