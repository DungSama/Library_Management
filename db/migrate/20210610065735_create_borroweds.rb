class CreateBorroweds < ActiveRecord::Migration[5.1]
  def change
    create_table :borroweds do |t|
      t.date :borrowed_date
      t.integer :borrowed_days

      t.timestamps
        
    end
  end
end
