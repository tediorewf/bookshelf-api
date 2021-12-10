class RemoveFirstNameFromReaders < ActiveRecord::Migration[6.1]
  def change
    remove_column :readers, :first_name
  end
end
