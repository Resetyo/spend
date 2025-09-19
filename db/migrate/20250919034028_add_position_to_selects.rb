class AddPositionToSelects < ActiveRecord::Migration[8.0]
  def change
    add_column :sources, :position, :integer, null: false, default: 0
    add_column :categories, :position, :integer, null: false, default: 0
  end
end
