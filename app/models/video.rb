class Video < ActiveRecord::Base
  has_many :video_genres
  has_many :genres, :through => :video_genres
  has_many :reviews, order: "created_at DESC"
  has_many :queue_items
  has_many :users, :through => :queue_items
  before_create :generate_token

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank? 
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def to_param
    token
  end

  def average_rating
    return 0 if review_rating.empty?
    (review_rating.inject(:+).to_f / review_rating.size).round(1)
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def review_rating
    reviews.map(&:rating)
  end

end