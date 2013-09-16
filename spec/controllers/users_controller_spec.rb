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
    context "successful user sign up" do
      it "redirects to the sign in path" do
        result = double(:sign_up_result, successful?: true)
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to sign_in_path
      end
    end

    context "failed user sign up" do
      it "renders the new template" do
        result = double(:sign_up_result, successful?: false, error_message: "An error occured")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stipeToken: '123450987'
        expect(response).to render_template :new
      end

      it "sets the flash error message" do
        result = double(:sign_up_result, successful?: false, error_message: "An error occured")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stipeToken: '123450987'
        expect(flash[:error]).to eq("An error occured")
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

  describe "GET new_with_invitation_token" do
    it "renders the :new view template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end
    it "sets @user with recipient's email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end
    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end
    it "redirects to expired token page for invalid tokens" do
      get :new_with_invitation_token, token: '12345asdfg'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "GET edit" do
    context "with authenticated user" do
      it "sets the @user instance variable" do
        set_current_user
        user = current_user
        get :edit, id: user.id
        expect(assigns(:user)).to eq(user)
      end
    end

    it_behaves_like "unauthenticated user" do
      user = Fabricate(:user)
      let(:action) { get :edit, id: user.id }
    end
  end
end