class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_presence_of :rating, :content

  def average_rating
    review_rating.inject(:+) / review_rating.size
  end

  def review_rating
    Review.all.map { |review| review.rating }
  end

end