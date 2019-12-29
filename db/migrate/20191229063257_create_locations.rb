class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :google_address
      t.bigint :listing_id
      t.string :location_type
      t.bigint :community_id
      t.timestamps
    end
  end
end
