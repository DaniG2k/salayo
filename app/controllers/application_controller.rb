class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  layout 'application'

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  protected

  def configure_permitted_parameters
    registration_keys = %i[
      first_name
      last_name
      locale
      role
      birth_date
      biography
      gender
      time_zone
      pictures
      profile_picture
      profile_picture_cache
      remove_profile_picture
    ]
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: registration_keys)
    devise_parameter_sanitizer.permit(:account_update, keys: registration_keys)
  end

  private

  def not_authorized
    flash[:warning] = 'You are not allowed to access that resource.'
    redirect_to dashboard_path
  end

  def set_locale
    I18n.locale = current_user.try(:locale) || params[:locale] || I18n.default_locale
  end
end
