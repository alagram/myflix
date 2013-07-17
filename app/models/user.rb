class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, order: :position
  has_many :videos, :through => :queue_items

  before_validation { email.downcase.strip if email }

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password
end