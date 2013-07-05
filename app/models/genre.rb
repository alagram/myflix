class Genre < ActiveRecord::Base
  has_many :video_genres
  has_many :videos, :through => :video_genres
  # has_many :videos, order: 'created_at DESC', limit: 6, :through => :video_genres
end