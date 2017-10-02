class AdvertisementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  def index
    @advertisements = Advertisement.where
                                  .not(user: current_user)
                                  .order(created_at: :desc)
                                  .includes(:user)
    @mine = false
  end

  def show
  end

  def new
    @advertisement = Advertisement.new
  end

  def edit
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)
    @advertisement.user = current_user

    if @advertisement.save
      redirect_to @advertisement, notice: 'Advertisement was successfully created.'
    else
      render :new
    end
  end

  def update
    if @advertisement.update(advertisement_params)
      redirect_to @advertisement, notice: 'Advertisement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @advertisement.destroy
    redirect_to my_advertisements_path, notice: 'Advertisement was successfully destroyed.'
  end

  def mine
    @advertisements = Advertisement.where(user: current_user).includes(:user)
    @mine = true
  end

  private

    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = 'That advertisement does not appear to exist.'
      redirect_to advertisements_path
    end

    def advertisement_params
      params.require(:advertisement).permit(:title, :body, :ad_type)
    end
end
