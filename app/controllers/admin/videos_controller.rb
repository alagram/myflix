class Admin::VideosController < AdminsController

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

end