class AddTargetToSpendItems < ActiveRecord::Migration[8.0]
  def change
    add_column :spend_items, :target_id, :integer
  end
end
