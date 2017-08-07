class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin!
  layout 'dashboard'

  def index
  end

  private
    def authorize_admin!
      authenticate_user!

      unless current_user.has_role?(:admin)
        redirect_to dashboard_path, alert: 'You must be an admin to access that resource.'
      end
    end
end
