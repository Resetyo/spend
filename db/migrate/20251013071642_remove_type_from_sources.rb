class RemoveTypeFromSources < ActiveRecord::Migration[8.0]
  def change
    remove_column :sources, :type, :integer
  end
end
