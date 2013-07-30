require 'spec_helper'

describe VideosController do
  describe "GET show" do
    
    let(:video) { Fabricate(:video) }
    
    context "with authenticated users" do

      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "sets the @video variable if user is authenticated" do
        get :show, id: video.token
        expect(assigns(:video)).to eq(video)
      end

      it "sets the @reviews variable if user is authenticated" do
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.token
        expect(assigns(:reviews)).to match_array([review1, review2])
      end

    end

    context "with unauthenticated users" do
      it "redirects user to sign in page if user unauthenticated" do
        get :show, id: video.token
        expect(response).to redirect_to sign_in_path
      end
    end
    
  end

  describe "POST show" do
    
    let(:toy_story) { Fabricate(:video, title: "Toy Story") }

    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :search, search_term: "tory"
      expect(assigns(:results)).to eq([toy_story])
    end
    it "redirects user to sign in page if user unauthenticated" do
      get :search, search_term: "tory"
      expect(response).to redirect_to sign_in_path
    end
  end
end