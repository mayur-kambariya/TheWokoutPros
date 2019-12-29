class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.bigint :custom_field_option_title_id
      t.bigint :community_id
      t.string :author_id
      t.bigint :category_id
      t.bigint :listing_shape_id
      t.string :title
      t.text :description
      t.datetime :valid_until
      t.boolean :open
      t.text :origin
      t.float :price
      t.bigint :user_id
      t.timestamps
    end
  end
end
