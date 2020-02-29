class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    if current_user.try(:type) == 'AdminUser' #Assuming there is such a function
      members_path
    else
      session[:previous_url] || root_path
    end
  end

  def authorize_admin
      redirect_to  root_path unless current_user.try(:type) == 'AdminUser'
      #redirects to previous page
  end
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(root_path)
    end
   
end
