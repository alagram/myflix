class Video < ActiveRecord::Base
  has_many :video_genres
  has_many :genres, :through => :video_genres
end