class RemoveBorrowedIdFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :borrowed_id, :integer
  end
end
