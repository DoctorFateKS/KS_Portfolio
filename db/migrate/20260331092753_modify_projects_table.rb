class ModifyProjectsTable < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :role_jp, :string
    add_column :projects, :results, :string

    remove_column :projects, :context, :text
    remove_column :projects, :usages_decisions, :text
    remove_column :projects, :solutions, :text
    remove_column :projects, :impact_quote, :text
    remove_column :projects, :featured, :boolean
    remove_column :projects, :category, :string
    remove_column :projects, :status, :string
  end
end
