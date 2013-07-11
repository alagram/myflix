class Video < ActiveRecord::Base
  has_many :video_genres
  has_many :genres, :through => :video_genres
  has_many :reviews, order: "created_at DESC"

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank? 
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def average_rating
    (review_rating.inject(:+).to_f / review_rating.size).round(1)
  end

  def review_rating
    reviews.map { |review| review.rating }
  end

end