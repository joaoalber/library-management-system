class AddBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :genre, null: false
      t.string :isbn, null: false
      t.integer :total_copies, null: false, default: 0
      t.timestamps
    end

    create_table :borrowings do |t|
      t.integer :book_id, null: false
      t.integer :user_id, null: false
      t.datetime :return_at, null: false
      t.datetime :returned_at
      t.timestamps
    end

    add_index :borrowings, :user_id
    add_index :borrowings, :book_id
  end
end
