require 'spec_helper'

describe Video do
  # Shoulda matchers
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should have_many(:video_genres) }
  it { should have_many(:genres).through(:video_genres) }

  describe "#Video.search_by_title" do
    it "returns an empty array of videos if no videos are found" do
      video = Video.create(title: "The Fast and Furious", description: "Action Packed.")
      expect(Video.search_by_title("example")).to eq([])
    end

    it "returns an array if one video is found" do
      video = Video.create(title: "The Fast and Furious", description: "Action Packed.")
      expect(Video.search_by_title("Action")).to eq([video])
    end

    it "returns an array of videos if multiple videos are found" do
      video = Video.create(title: "The Fast and Furious", description: "Racing and action packed")
      video1 = Video.create(title: "Redemption", description: "Action Packed.")
      expect(Video.search_by_title("action")).to eq([video, video1])
    end
  end
end