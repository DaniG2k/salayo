class AdvertisementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  def index
    @advertisements = Advertisement.where
                                  .not(user: current_user)
                                  .order(created_at: :desc)
                                  .includes(:user)
  end

  def show
    authorize @advertisement, :show?
  end

  def new
    @advertisement = Advertisement.new
    authorize @advertisement, :new?
  end

  def edit
    authorize @advertisement, :edit?
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)
    @advertisement.user = current_user

    authorize @advertisement, :create?
    if @advertisement.save
      redirect_to @advertisement, notice: 'Advertisement was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @advertisement, :update?
    if @advertisement.update(advertisement_params)
      redirect_to @advertisement, notice: 'Advertisement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @advertisement, :destroy?
    @advertisement.destroy
    redirect_to my_advertisements_path, notice: 'Advertisement was successfully destroyed.'
  end

  def mine
    @advertisements = Advertisement.where(user: current_user).includes(:user)
  end

  def add_picture
    @advertisement = Advertisement.find params[:id]
    @picture = @advertisement.pictures.create(image: params[:file])
    @picture.save
  end

  private

    def set_advertisement
      @advertisement = Advertisement.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = 'That advertisement does not appear to exist.'
      redirect_to advertisements_path
    end

    def advertisement_params
      params.require(:advertisement).permit(:title, :body, :ad_type)
    end
end
