class VideoDecorator < Draper::Decorator
  delegate_all

  def display_rating
    if rating
      "#{model.rating} / 5.0"
    else
      "N/A"
    end
  end

  def rating
    model.reviews.average(:rating).round(1) if model.reviews.average(:rating)
  end
end