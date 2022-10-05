class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:blog_url])
  end

  def after_sign_out_path_for(resource_or_scope)
    login_path
  end
end
