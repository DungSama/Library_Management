class CreateReserves < ActiveRecord::Migration[5.1]
  def change
    create_table :reserves do |t|
      t.string :name
      t.string :author
      t.string :category
      t.string :publish
      t.string :describe

      t.timestamps
    end
  end
end
