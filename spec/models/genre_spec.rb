require 'spec_helper'

describe Genre do
  # shoulda matchers
  it { should have_many(:video_genres) }
  it { should have_many(:videos).through(:video_genres) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    it "returns the videos in reverse chronological order by created_at" do
      drama = Genre.create(name: "Drama")
      ted = Video.create(title: "Ted", description: "Funny story", created_at: 1.day.ago)
      ted.genres << drama
      family_guy = Video.create(title: "Family Guy", description: "Funny family story")
      family_guy.genres << drama
      expect(drama.recent_videos).to eq([family_guy, ted])
    end
    it "returns all the videos if there are less than 6 videos" do
      drama = Genre.create(name: "Drama")
      ted = Video.create(title: "Ted", description: "Funny story", created_at: 1.day.ago)
      ted.genres << drama
      family_guy = Video.create(title: "Family Guy", description: "Funny family story")
      family_guy.genres << drama
      expect(drama.recent_videos.count).to eq(2)
    end
    it "returns 6 videos if there are more than 6 vidoes" do
      drama = Genre.create(name: "Drama")
      ted = Video.create(title: "Ted", description: "Funny story")
      8.times { ted.genres << drama }
      expect(drama.recent_videos.count).to eq(6)
    end
    it "returns the most recent 6 videos" do
      drama = Genre.create(name: "Drama")
      ted = Video.create(title: "Ted", description: "Funny story")
      6.times { ted.genres << drama }
      family_guy = Video.create(title: "Family Guy", description: "Funny family story", created_at: 1.day.ago)
      family_guy.genres << drama
      expect(drama.recent_videos).not_to include(family_guy)
    end
    it "returns an empty array if the genre does not have any vidoes" do
      drama = Genre.create(name: "Drama")
      expect(drama.recent_videos).to eq([])
    end
  end
end