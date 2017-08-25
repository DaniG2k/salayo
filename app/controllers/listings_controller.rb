class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  def index
    @listings = policy_scope Listing
  end

  def new
    @listing = Listing.new
    gon.push({
      google_maps_api_key: ENV['GOOGLE_MAPS_API_KEY']
    })
  end

  def create
    @listing = Listing.new listing_params
    @listing.owner = current_user
    #authorize @listing, :create?

    if @listing.save
      current_user.add_role(:owner, @listing)

      flash[:notice] = 'Listing was created successfully!'
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def show
    authorize @listing, :show?
  end

  def edit
    authorize @listing, :edit?

    gon.push({
      lat: @listing.lat,
      lng: @listing.lng,
      google_maps_api_key: ENV['GOOGLE_MAPS_API_KEY']
    })
  end

  def update
    authorize @listing, :update?
    @listing.owner = current_user

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
    authorize @listing, :destroy?
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
