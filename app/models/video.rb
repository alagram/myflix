class Video < ActiveRecord::Base
  has_many :video_genres
  has_many :genres, :through => :video_genres

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    if search_term
      find(:all, :conditions => ['description LIKE ?', "%#{search_term}%"])
    end
  end

end