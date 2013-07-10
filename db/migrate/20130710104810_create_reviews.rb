class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews do |t|
      t.text :content
      t.integer :user_id
      t.integer :video_id
      t.integer :rating

      t.timestamps
    end
  end

  def down
    drop_table :reviews
  end
end
