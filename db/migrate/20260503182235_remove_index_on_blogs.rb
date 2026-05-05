class RemoveIndexOnBlogs < ActiveRecord::Migration[8.0]
  def change
    remove_index(:blogs, :created_at)
    remove_index(:blogs, :title)
  end
end
