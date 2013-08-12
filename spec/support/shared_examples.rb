shared_examples "unauthenticated user" do
  it "redirects to the sign in path" do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples "requires admin" do
  it "redirects to the home path" do
    session[:user_id] = Fabricate(:user)
    action
    expect(response).to redirect_to home_path
  end
end

shared_examples "tokenable" do
  it "generates a random token when the user is created" do
    expect(object.token).to be_present
  end
end