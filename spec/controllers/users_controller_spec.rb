require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do

      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user record" do
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in path" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid input" do

      before do 
        post :create, user: { email: "al@example.com", password: "12345" }
      end

      it "does not create user record" do
        expect(User.count).to eq(0)
      end

      it "renders :new template" do
        expect(response).to render_template :new
      end

      it "sets the @user variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "email sending" do
      
      after { ActionMailer::Base.deliveries.clear }

      it "sends out email to the user with valid inputs" do
        post :create, user: { email: "alice@example.com", password: "12345", full_name: "Alice Doe" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["alice@example.com"])
      end
      it "sends out email containing the user's password with valid inputs" do
        post :create, user: { email: "alice@example.com", password: "12345", full_name: "Alice Doe" }
        expect(ActionMailer::Base.deliveries.last.body).to include("12345")
      end
      it "does not send out email with invalid inputs" do
        post :create, user: { email: "alice@example.com" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET show" do
    context "with authenticated users" do
      before { set_current_user }
      it "sets @user instance variable" do
        current_user
        get :show, id: current_user.id
        expect(assigns(:user)).to eq(current_user) 
      end
    end

    it_behaves_like "unauthenticated user" do
      let(:action) { get :show, id: 1 }
    end
  end
end