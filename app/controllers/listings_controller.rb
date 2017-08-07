class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update]
  layout 'dashboard'

  def index
    @listings = Listing.where(user_id: current_user.id)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new listing_params

    if @listing.save
      flash[:notice] = 'Listing was successfully created!'
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
  end

  def destroy
    if @listing.destroy
      redirect_to dashboard_path, notice: 'Listing was successfully destroyed!'
    else
      flash.now[:notice] = 'ArtiListingcle was not destroyed.'
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end
end