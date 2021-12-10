class RemoveLastNameFromReaders < ActiveRecord::Migration[6.1]
  def change
    remove_column :readers, :last_name
  end
end
