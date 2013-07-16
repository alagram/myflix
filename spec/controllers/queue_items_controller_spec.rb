require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated users" do
      it "sets @queue_items instance variable" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, video: video, user: current_user)
        queue_item2 = Fabricate(:queue_item, video: video, user: current_user)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end

    end

    context "with unauthenticated users" do
      it "should redirect to sign in page" do
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      it "redirects to the my queue page" do
        session[:user_id] =  Fabricate(:user)
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
      it "creates a queue item" do
        session[:user_id] =  Fabricate(:user)
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it "creates the queue item that is associated with the video" do
        session[:user_id] =  Fabricate(:user)
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq(video)
      end
      it "creates the queue item that is associated with the signed in user" do
        jack = Fabricate(:user)
        session[:user_id] =  jack.id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq(jack)
      end
      it "puts the video as the last one in the queue" do
        jack = Fabricate(:user)
        session[:user_id] = jack.id
        ted = Fabricate(:video)
        Fabricate(:queue_item, video: ted, user: jack)
        south_park = Fabricate(:video)
        post :create, video_id: south_park.id
        south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: jack.id).first
        expect(south_park_queue_item.position).to eq(2)
      end
      it "does not add the video to the queue if the video is already queued" do
        jack = Fabricate(:user)
        session[:user_id] = jack.id
        ted = Fabricate(:video)
        Fabricate(:queue_item, video: ted, user: jack)
        post :create, video_id: ted.id
        expect(jack.queue_items.count).to eq(1)
      end
    end

    context "with unauthenticated users" do
      it "redirects to sign in page" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "DELETE destroy" do
    context "with authenticated users" do
      it "sets @queue_item variable" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: current_user)
        delete :destroy, id: queue_item.id
        expect(assigns(:queue_item)).to eq(queue_item)
      end
      it "deletes a queue item" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: current_user)
        delete :destroy, id: queue_item.id
        # require 'pry'; binding.pry
        expect(QueueItem.count).to eq(0)
      end
      it "does not delete the queue item if it is not in the current user's queue" do
        alice = Fabricate(:user)
        jack = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item = Fabricate(:queue_item, video: video, user: jack)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end
      it "redirect_to my_queue path" do
        session[:user_id] = Fabricate(:user)
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
    end

    context "with unauthenticated users" do
      it "redirects to sign in path" do
        delete :destroy, id: 2
        expect(response).to redirect_to sign_in_path
      end
    end
  end

end