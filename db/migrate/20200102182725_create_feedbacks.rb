class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
    	t.text :content
    	t.bigint :user_id
    	t.bigint :community_id
    	t.string :email
    	t.string :url
      t.timestamps
    end
  end
end
