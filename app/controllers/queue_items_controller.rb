class QueueItemsController < ApplicationController

  before_filter :require_user

  def index
    @queue_items = current_user.queue_items  
  end

  def create
    @video =  Video.find(params[:video_id])
   
    @queue_item = QueueItem.create(video: @video, user: current_user) unless video_already_queued?(@video)

    redirect_to @video, notice: "Video successfully added to your queue."
  end

  def destroy
    @queue_item = QueueItem.find(params[:id])
    @queue_item.delete
    redirect_to my_queue_path
  end

end