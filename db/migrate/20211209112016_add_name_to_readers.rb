class AddNameToReaders < ActiveRecord::Migration[6.1]
  def change
    add_column :readers, :name, :string, default: ""
  end
end
