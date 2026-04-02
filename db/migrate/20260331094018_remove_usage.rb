class RemoveUsage < ActiveRecord::Migration[8.0]
  def change
    remove_column :projects, :usage_decisions, :text
  end
end
