class DropContacts < ActiveRecord::Migration[7.0]
  def up
    drop_table :contacts, if_exists: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't restore the contacts table"
  end
end
