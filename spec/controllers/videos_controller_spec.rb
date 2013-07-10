require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets the @video variable if user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets the @reviews variable if user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "redirects user to sign in page if user unauthenticated" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST show" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      toy_story = Fabricate(:video, title: "Toy Story")
      get :search, search_term: "tory"
      expect(assigns(:results)).to eq([toy_story])
    end
    it "redirects user to sign in page if user unauthenticated" do
      toy_story = Fabricate(:video, title: "Toy Story")
      get :search, search_term: "tory"
      expect(response).to redirect_to sign_in_path
    end
  end
end