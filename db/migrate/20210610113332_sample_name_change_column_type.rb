class SampleNameChangeColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column(:borroweds, :borrowed_days, :date)
  end
end
