class AddBorrowedIdToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :borrowed_id, :integer
  end
end
