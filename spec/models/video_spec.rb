require 'spec_helper'

describe Video do
  # Shoulda matchers
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should have_many(:video_genres) }
  it { should have_many(:genres).through(:video_genres) }
  it { should have_many(:reviews).order("created_at DESC") }

  it { should have_many(:queue_items) }
  it { should have_many(:users).through(:queue_items) }

  describe "#average_rating" do
    it "returns 0 if no rating is associated with a video" do
      video = Fabricate(:video)
      expect(Video.first.average_rating).to eq(0)
    end
    it "returns a rating if one rating is associated with a video" do
      review = Fabricate(:review)
      video = Fabricate(:video)
      video.reviews << review
      expect(Video.first.average_rating).to eq(review.rating)
    end
    it "returns average rating if video has more ratings" do
      review = Fabricate(:review)
      review2 = Fabricate(:review)
      video = Fabricate(:video)
      video.reviews << review
      video.reviews << review2
      total_rating = (review.rating + review2.rating).to_f
      expect(Video.first.average_rating).to eq((total_rating / 2).round(1))
    end
  end

  describe "search_by_title" do
    it "returns an empty array of videos if no videos are found" do
      video = Video.create(title: "The Fast and Furious", description: "Action Packed.")
      expect(Video.search_by_title("example")).to eq([])
    end

    it "returns an array if one video is found" do
      video = Video.create(title: "The Fast and Furious", description: "Fast and Furious 6")
      video1 = Video.create(title: "Redemption", description: "Action Packed.")
      expect(Video.search_by_title("Fast")).to eq([video])
    end

    it "returns an array of one video for a partial match" do
      video = Video.create(title: "The Fast and Furious", description: "Fast and Furious 6")
      video1 = Video.create(title: "Redemption", description: "Action Packed.")
      expect(Video.search_by_title("Fast")).to eq([video])
    end

    it "returns an array of all matches ordered by created_at" do
      video = Video.create(title: "The Fast and Furious", description: "Racing and action packed", created_at: 1.day.ago)
      video1 = Video.create(title: "The Fast Redemption", description: "Action Packed.")
      expect(Video.search_by_title("Fast")).to eq([video1, video])
    end

    it "returns an empty array for a search with an empty string" do
      video = Video.create(title: "The Fast Redemption", description: "Action Packed.")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end