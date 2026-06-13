class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authorize

  protected

  def authorize
    unless @current_user = User.find_by(id: session[:user_id])
      redirect_to login_url, alert: "Please log in" if request.url != login_url
    end
  end
end
