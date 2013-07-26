require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets @relationships to the current user's following relationships" do
      set_current_user
      john = current_user
      alice = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: john, leader: alice)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
    it_behaves_like "unauthenticated user" do
      let(:action) { get :index }
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "unauthenticated user" do
      let(:action) { delete :destroy, id: 2 }
    end
    it "redirects to the people page" do
      set_current_user
      john = current_user
      alice = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: john, leader: alice)
      delete :destroy, id: relationship.id
      expect(response).to redirect_to people_path
    end
    it "deletes the relationship if the current user is the follower" do
      set_current_user
      john = current_user
      alice = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: john, leader: alice)
      delete :destroy, id: relationship.id
      expect(Relationship.count).to eq(0)
    end
    it "does not delete the relationship if the current user is not the follower" do
      set_current_user
      john = current_user
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bob, leader: alice)
      delete :destroy, id: relationship.id
      expect(Relationship.count).to eq(1)
    end
  end
end