class VideosController < AuthenticatedController
  
  def index
    @genres = Genre.all
  end

  def show
    @video = VideoDecorator.decorate(Video.find_by_token(params[:id]))
    @reviews = @video.reviews
    @review = Review.new
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end

end