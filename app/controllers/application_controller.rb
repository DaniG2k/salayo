class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

  private

    def not_authorized
      flash[:warning] = 'You are not allowed to access that resource.'
      redirect_to dashboard_path
    end

    def set_locale
      I18n.locale = current_user.try(:locale) || params[:locale] || I18n.default_locale
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
