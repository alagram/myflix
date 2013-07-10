class Video < ActiveRecord::Base
  has_many :video_genres
  has_many :genres, :through => :video_genres
  has_many :reviews

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank? 
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

end