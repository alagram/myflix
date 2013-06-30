class VideosController < ApplicationController

  def index
    @videos = Video.order("created_at DESC")
    @genre = Genre.all
  end

  def show
    @video = Video.find(params[:id])
  end

end