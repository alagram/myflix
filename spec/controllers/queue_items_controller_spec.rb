require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do

    before { set_current_user }

    context "with authenticated users" do
      it "sets @queue_items instance variable" do
        jack = current_user
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, video: video1, user: jack)
        queue_item2 = Fabricate(:queue_item, video: video2, user: jack)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
    end

    
    it_behaves_like "unauthenticated user" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    
    before { set_current_user }

    context "with authenticated users" do
      it "redirects to the my queue page" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
      it "creates a queue item" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it "creates the queue item that is associated with the video" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq(video)
      end
      it "creates the queue item that is associated with the signed in user" do
        jack = current_user
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq(jack)
      end
      it "puts the video as the last one in the queue" do
        jack = current_user
        ted = Fabricate(:video)
        Fabricate(:queue_item, video: ted, user: jack)
        south_park = Fabricate(:video)
        post :create, video_id: south_park.id
        south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: jack.id).first
        expect(south_park_queue_item.position).to eq(2)
      end
      it "does not add the video to the queue if the video is already queued" do
        jack = current_user
        ted = Fabricate(:video)
        Fabricate(:queue_item, video: ted, user: jack)
        post :create, video_id: ted.id
        expect(jack.queue_items.count).to eq(1)
      end
    end

    it_behaves_like "unauthenticated user" do
      let(:video) { Fabricate(:video) }
      let(:action) { post :create, video_id: video.id }
    end
  end

  describe "DELETE destroy" do

    before { set_current_user }

    context "with authenticated users" do
      it "sets @queue_item variable" do
        jack = current_user
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: jack)
        delete :destroy, id: queue_item.id
        expect(assigns(:queue_item)).to eq(queue_item)
      end
      it "deletes a queue item" do
        jack = current_user
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: jack)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end
      it "normalizes the remaining queue items" do
        jack = current_user
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: jack, position: 3)
        queue_item2 = Fabricate(:queue_item, user: jack, position: 5)
        delete :destroy, id: queue_item2.id
        expect(QueueItem.first.position).to eq(1)
      end
      it "does not delete the queue item if it is not in the current user's queue" do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: alice)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end
      it "redirect_to my_queue path" do
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
    end

    it_behaves_like "unauthenticated user" do
      let(:action) { delete :destroy, id: 2 }
    end
  end

  describe "POST update_queue" do

    before { set_current_user }

    context "with valid inputs" do
      let(:jack) { current_user }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: jack, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: jack, video: video, position: 2) }

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(jack.queue_items).to eq([queue_item2, queue_item1])
      end
      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(jack.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid inputs" do

      let(:video) { Fabricate(:video) }
      let(:jack) { current_user }
      let(:queue_item1) { Fabricate(:queue_item, user: jack, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: jack, video: video, position: 2) }

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 1.2}, {id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end

      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 1.2}, {id: queue_item2.id, position: 2}]
        expect(flash[:error]).to be_present
      end
      it "does not change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 5.4}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    it_behaves_like "unauthenticated user" do
      let(:action) { post :update_queue, queue_items: [{id: 1, position: 3}, {id: 2, position: 4}] }
    end

    context "with queue items that does not belong to the current user" do
      it "does not change the queue items" do
        set_current_user
        jack = current_user
        alice = Fabricate(:user)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: jack, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 5}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end

end