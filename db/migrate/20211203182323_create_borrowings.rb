class CreateBorrowings < ActiveRecord::Migration[6.1]
  def change
    create_table :borrowings do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :reader, null: false, foreign_key: true

      t.timestamps
    end
  end
end
