require 'spec_helper'

describe Genre do
  it "saves itself" do
    genre = Genre.new(name: "Romance")
    genre.save
    expect(Genre.first.name).to eq("Romance")
  end

  # shoulda matchers
  it { should have_many(:video_genres) }
  it { should have_many(:videos).through(:video_genres) }

end