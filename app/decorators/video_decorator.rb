class VideoDecorator < Draper::Decorator
  delegate_all

  def display_rating
    object.rating.present? ? "#{object.rating} / 5.0" : "N/A" 
  end

end