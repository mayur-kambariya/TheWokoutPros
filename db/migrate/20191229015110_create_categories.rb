class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.bigint :community_id
      t.integer :sort_priority
      t.string :url
      t.timestamps
    end
  end
end
