class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :company
      t.string :project_type
      t.text :message, null: false
      t.string :ip_address, null: false

      t.timestamps
    end

    add_index :contacts, :email
    add_index :contacts, :ip_address
    add_index :contacts, :created_at
  end
end
