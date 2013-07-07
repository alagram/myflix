require 'spec_helper'

describe Video do
  # Shoulda matchers
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should have_many(:video_genres) }
  it { should have_many(:genres).through(:video_genres) }

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