class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  layout 'dashboard'

  def show
    authorize @user, :show?
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
