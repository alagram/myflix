require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders :new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to home_path if user is logged in" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do

      before do
        ted = Fabricate(:user)
        post :create, email: ted.email, password: ted.password
      end

      it "sets the signed in user in the session" do
        expect(session[:user_id]).to eq(1)
      end
      it "redirects to the home_path" do
        expect(response).to redirect_to home_path
      end
      it "sets notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid credentials" do

      before do
        ted = Fabricate(:user)
        post :create, email: ted.email, password: ted.password + ';;kjsds'
      end

      it "does not set the user into the session" do
        expect(session[:user_id]).to be_nil
      end
      it "sets flash[:error]" do
        expect(flash[:error]).not_to be_blank
      end
      it "redirects to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "GET destroy" do

    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to root_path" do
      expect(response).to redirect_to root_path
    end
    it "sets notice" do
      expect(flash[:notice]).not_to be_blank
    end
  end
end