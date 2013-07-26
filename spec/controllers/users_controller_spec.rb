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