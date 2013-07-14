class QueueItemsController < ApplicationController

  before_filter :require_user

  def index
    @queue_items = current_user.queue_items  
  end

  def create
    @video =  Video.find(params[:video_id])
   
   
    @queue_item = QueueItem.create(video: @video, user: current_user) unless video_already_queued?(@video)

    redirect_to @video  

  end

end