class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  def index
    @listings = Listing.with_roles(:owner, current_user)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new listing_params

    if @listing.save
      current_user.add_role(:owner, @listing)

      flash[:notice] = 'Listing was created successfully!'
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def show
  end

  def edit
    authorize @listing, :edit?
  end

  def update
    if @listing.update(listing_params)
      current_user.add_role(:owner, @listing)

      flash[:notice] = 'Listing has been updated!'
      redirect_to @listing
    else
      flash.now[:alert] = 'Listing has not been updated.'
      render :edit
    end
  end

  def destroy
    if @listing.destroy
      redirect_to listings_path, notice: 'Listing was successfully deleted!'
    else
      flash.now[:notice] = 'Listing was not destroyed.'
    end
  end

  private

    def listing_params
      params.require(:listing).permit(:name, :property_type, :lat, :lng)
    end

    def set_listing
      @listing = Listing.find(params[:id])
    end
end
