require 'spec_helper'

describe ReviewsController do
  describe "POST create" do

    let(:video) { video = Fabricate(:video) }
    before { set_current_user }

    context "with authenticated users" do

      let(:jack) { current_user }

      context "with valid inputs" do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end
        
        it "creates a review" do
          expect(Review.count).to eq(1)
        end
        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end
        it "creates a review associated with signed in user" do
          expect(Review.first.user).to eq(jack)
        end
        it "redirects to the video show page" do
          expect(response).to redirect_to video
        end
      end

      context "with invalid inputs" do
        it "does not create a review" do
          post :create, review: { content: "Its ok" }, video_id: video.id
          expect(Review.count).to eq(0)
        end
        it "renders the videos/show template" do
          post :create, review: { content: "Its ok" }, video_id: video.id
          expect(response).to render_template 'videos/show'
        end
        it "sets @video" do
          post :create, review: { content: "Its ok" }, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end
        it "sets @review" do
          review = Fabricate(:review, video: video)
          post :create, review: { content: "Its ok" }, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end

    it_behaves_like "unauthenticated user" do
      let(:action) { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }
    end
  end
end