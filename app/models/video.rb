class Video < ActiveRecord::Base
  include Tokenable
  
  has_many :video_genres
  has_many :genres, :through => :video_genres
  has_many :reviews, order: "created_at DESC"
  has_many :queue_items
  has_many :users, :through => :queue_items

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank? 
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def to_param
    token
  end

  def rating
    reviews.average(:rating).round(1) if reviews.average(:rating)
  end

end