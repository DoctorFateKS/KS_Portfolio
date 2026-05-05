class UpdateBlogs < ActiveRecord::Migration[8.0]
  def change
    remove_column(:blogs, :excerpt)
    remove_column(:blogs, :category)
    remove_column(:blogs, :published)
    remove_column(:blogs, :view_count)
    add_column(:blogs, :jp_title, :string)
  end
end
