class CreateListingShapes < ActiveRecord::Migration[5.2]
  def change
    create_table :listing_shapes do |t|
      t.bigint :community_id
      t.string :name
      t.timestamps
    end
  end
end
