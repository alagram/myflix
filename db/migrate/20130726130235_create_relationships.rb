class CreateRelationships < ActiveRecord::Migration
  def up
    create_table :relationships do |t|
      t.integer :leader_id
      t.integer :follower_id

      t.timestamps
    end
  end

  def down
    drop_table :relationships
  end
end
