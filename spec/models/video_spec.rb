require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Salmon fishing", description: "Nice one", small_cover_url: "tmp/before_sunset.jpg", large_cover_url: "tmp/monk_large.jpg")
    video.save
    expect(video.title).to eq("Salmon fishing")
  end

  it "is invalid without a title" do
    expect(Video.new(title: nil)).to have(1).errors_on(:title)
  end

  it "is invalid without a description" do
    expect(Video.new(description: nil)).to have(1).errors_on(:description)
  end

  # Shoulda matchers
  it { should validate_presence_of(:title) }

  it { should validate_presence_of(:description) }

  it { should have_many(:video_genres) }
  it { should have_many(:genres).through(:video_genres) }
  
end