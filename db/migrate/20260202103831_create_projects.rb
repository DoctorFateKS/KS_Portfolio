class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :tagline
      t.text   :context
      t.text   :role_description
      t.string :stack
      t.text   :usage_decisions
      t.text   :challenges
      t.text   :solutions
      t.text   :impact_quote
      t.string :github_url
      t.string :demo_url
      t.boolean :featured, default: false
      t.string :category
      t.string :status

      t.timestamps
    end
  end
end
