class CreateSpendItems < ActiveRecord::Migration[8.0]
  def change
    create_table :spend_items do |t|
      t.string :title
      t.integer :category_id
      t.integer :amount
      t.integer :source_id
      t.integer :like_id

      t.timestamps
    end
  end
end
