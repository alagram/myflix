require 'spec_helper'

describe Genre do
  # shoulda matchers
  it { should have_many(:video_genres) }
  it { should have_many(:videos).through(:video_genres) }
end