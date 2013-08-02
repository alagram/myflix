class CreateInvitations < ActiveRecord::Migration
  def up
    create_table :invitations do |t|
      t.integer :inviter_id
      t.string :recipient_name
      t.string :recipient_email
      t.text :message
      t.timestamps
    end
  end

  def down
    drop_table :invitations
  end
end
