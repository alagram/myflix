require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "ted")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("ted")
    end
  end

  describe "#rating" do

    let!(:video) { Fabricate(:video) }
    let!(:user) { Fabricate(:user) }
    let!(:queue_item) { Fabricate(:queue_item, user: user, video: video) }
    subject { queue_item.rating }

    it " returns the rating for a review when the review is present" do
      review = Fabricate(:review, user: user, video: video, rating: 3)
      expect(subject).to eq(3)
    end
    it "returns nil when the review is not present" do
      expect(subject).to eq(nil)
    end
  end

  describe "#rating=" do

    let!(:video) { Fabricate(:video) }
    let!(:user) { Fabricate(:user) }
    let!(:queue_item) { Fabricate(:queue_item, user: user, video: video) }
    subject { Review.first.rating }

    it "changes the rating of the review if the review is present" do
      review = Fabricate(:review, user: user, video: video, rating: 3)
      queue_item.rating = 5
      expect(subject).to eq(5)
    end
    it "clears the rating of the review if the review is present" do
      review = Fabricate(:review, user: user, video: video, rating: 3)
      queue_item.rating = nil
      expect(subject).to be_nil
    end
    it "creates a review with the rating if the review is not present" do
      queue_item.rating = 4
      expect(subject).to eq(4)
    end
  end
end