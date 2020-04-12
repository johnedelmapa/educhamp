class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :image])
    end

    def admin_user
      unless current_user.is_admin?
        flash[:alert] = "You are not authorized..."
        redirect_to root_url
      end
    end
end
  