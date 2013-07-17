class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :position, numericality: { only_integer: true }

  def video_title
    video.title
  end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end
  
end