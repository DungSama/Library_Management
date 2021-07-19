class AddRequestToReserves < ActiveRecord::Migration[5.1]
  def change
    add_column :reserves, :request, :string
  end
end
