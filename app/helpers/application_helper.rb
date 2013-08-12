module ApplicationHelper
  def options_for_video_reviews(selected=nil)
    options_for_select((1..5).map {|num| [pluralize(num, "Star"), num]}, selected)
  end

  def admin_options_for_genres
    Genre.all.map {|genre| [genre.name, genre.id]}
  end
end
