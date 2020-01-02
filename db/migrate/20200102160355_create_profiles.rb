class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :location
      t.text :display_name
      t.text :about_you
      t.bigint :user_id
      t.timestamps
    end
  end
end
