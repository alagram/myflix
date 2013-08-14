class AdminsController < AuthenticatedController
  before_filter :require_admin

  def require_admin
    unless current_user.admin?
      flash[:error] = "You are not authorised to do that."
      redirect_to home_path
    end
  end
end