class User < ActiveRecord::Base
  has_many :reviews, order: "created_at DESC"
  has_many :queue_items, order: :position
  has_many :videos, :through => :queue_items
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id

  before_validation { email.downcase.strip if email }

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end
end