require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated users" do

      it "show render queue_items/index page" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        get :index
        expect(response).to render_template :index
      end
      it "sets @queue_items instance variable" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        current_user.videos << video
        queue_items = current_user.queue_items
        get :index
        expect(assigns(:queue_items)).to eq(queue_items)
      end

    end

    context "with unauthenticated users" do
      it "should redirect to sign in page" do
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end

  end
end