class Video < ActiveRecord::Base
  has_many :video_genres
  has_many :genres, :through => :video_genres

  validates :title, presence: true
  validates :description, presence: true

end