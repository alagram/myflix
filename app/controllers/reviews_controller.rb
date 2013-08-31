class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    @video = VideoDecorator.decorate(Video.find_by_token(params[:video_id]))
    @review = @video.reviews.build(params[:review].merge!(user: current_user))

    if @review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

end