class AddStatusToBorroweds < ActiveRecord::Migration[5.1]
  def change
    add_column :borroweds, :status, :string
  end
end
