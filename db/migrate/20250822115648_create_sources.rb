class CreateSources < ActiveRecord::Migration[8.0]
  def change
    create_table :sources do |t|
      t.string :title
      t.integer :type

      t.timestamps
    end
  end
end
