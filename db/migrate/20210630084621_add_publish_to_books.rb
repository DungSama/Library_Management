class AddPublishToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :publish, :integer
  end
end
