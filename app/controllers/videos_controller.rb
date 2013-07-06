class VideosController < ApplicationController
  before_filter :require_user
  def index
    @genres = Genre.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    #binding.pry
    @search = Video.search_by_title(params[:search])
  end

end