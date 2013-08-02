require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }

  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:videos).through(:queue_items) }

  it "generates a random token when the user is created" do
    alice = Fabricate(:user)
    expect(alice.token).to be_present
  end

  describe "#follows?" do
    it "returns true if the user has a following relationship with another user" do
      john = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: john, follower: bob)
      expect(bob.follows?(john)).to be_true
    end
    it "returns false if the user does not have a following relationship with another user" do
      john = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: john, follower: bob)
      expect(john.follows?(bob)).to be_false
    end
  end

  describe "#follow" do
    it "follows another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow(bob)
      expect(alice.follows?(bob)).to be_true
    end
    it "does not follow one's self" do
      alice = Fabricate(:user)
      alice.follow(alice)
      expect(alice.follows?(alice)).to be_false
    end
  end
end