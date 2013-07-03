require 'spec_helper'

describe Video do
  # Shoulda matchers
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should have_many(:video_genres) }
  it { should have_many(:genres).through(:video_genres) }
  
end