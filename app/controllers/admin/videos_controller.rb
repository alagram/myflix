class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    if @video.save
      flash[:success] = "Successfully added video #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "Video not added. Please check error(s) below."
      render :new
    end
  end

  private
  def require_admin
    unless current_user.admin?
      flash[:error] = "You are not authorised to do that."
      redirect_to home_path
    end
  end
end