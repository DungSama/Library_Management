class AddBookToBorroweds < ActiveRecord::Migration[5.1]
  def change
    add_column :borroweds, :book_id, :integer
  end
end
