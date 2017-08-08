class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update]
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
      current_user.add_role :owner, @listing

      flash[:notice] = 'Listing was created successfully!'
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    # TODO
    current_user.add_role :owner, @listing
  end

  def destroy
    if @listing.destroy
      # TODO remove owner role from listing
      redirect_to dashboard_path, notice: 'Listing was successfully destroyed!'
    else
      flash.now[:notice] = 'ArtiListingcle was not destroyed.'
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
