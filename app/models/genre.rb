class Genre < ActiveRecord::Base
  has_many :video_genres
  has_many :videos, order: 'created_at DESC', :through => :video_genres

  def recent_videos
    videos.first(6)
  end
end