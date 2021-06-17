class AddUserIdToBorroweds < ActiveRecord::Migration[5.1]
  def change
    add_column :borroweds, :user_id, :interger
  end
end
