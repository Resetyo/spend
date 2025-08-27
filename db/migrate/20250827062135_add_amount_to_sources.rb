class AddAmountToSources < ActiveRecord::Migration[8.0]
  def change
    add_column :sources, :amount, :integer, default: 0, null: false
  end
end
