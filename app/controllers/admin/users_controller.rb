class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[destroy]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'User successfully destroyed.'
    else
      flash.now[:notice] = 'Unable to destroy user.'
      render :index
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end
end
