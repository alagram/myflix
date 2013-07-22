shared_examples "unauthenticated user" do
  it "redirects to the sign in path" do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
end