class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  	rescue_from CanCan::AccessDenied do |exception|
	  flash[:error] = "Access denied!"
	  redirect_to root_url
	end

	  private
	  
	  def logged_in?
	    current_user
	  end
	  helper_method :logged_in?
	  
	  def check_login
	    redirect_to login_path, alert: "You need to log in to view this page." if current_user.nil?
	  end
	
	protected
	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:username])
	end
end
