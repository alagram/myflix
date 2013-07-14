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

  describe "POST create" do
    context "with authenticated users" do
      it "sets the @video variable" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(assigns(:video)).to eq(video)
      end
      it "redirects to the video/show page" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to video
      end
      it "associates a video to the signed in user" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq(current_user)
      end
      it "does not associate video with signed in user if video already in queue" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        QueueItem.create(video: video, user: current_user)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it "sets notice" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with unauthenticated users" do
      it "redirects to sign in path" do
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
        queue_item = QueueItem.create(video: video, user: current_user)
        delete :destroy, video_id: video.id, id: queue_item.id
        expect(assigns(:queue_item)).to eq(queue_item)
      end
      it "deletes a queue item" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        queue_item = QueueItem.create(video: video, user: current_user)
        delete :destroy, video_id: video.id, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end
      it "redirect_to my_queue path" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        video = Fabricate(:video)
        queue_item = QueueItem.create(video: video, user: current_user)
        delete :destroy, video_id: video.id, id: queue_item.id
        expect(response).to redirect_to(my_queue_path)
      end
    end

    context "with unauthenticated users" do
      it "redirects to sign in path" do
        video = Fabricate(:video)
        current_user = Fabricate(:user)
        queue_item = QueueItem.create(video: video, user: current_user)
        delete :destroy, video_id: video.id, id: queue_item.id
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

end