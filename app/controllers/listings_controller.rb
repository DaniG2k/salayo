class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  def index
    @listings = policy_scope Listing
  end

  def new
    @listing = Listing.new

    authorize @listing, :new?
  end

  def create
    listing_obj = JSON.parse(params[:listing])
    @listing = Listing.new listing_obj
    @listing.owner = current_user

    authorize @listing, :create?
    respond_to do |format|
      if @listing.save
        current_user.add_role(:owner, @listing)
        format.html { redirect_to listing_path(@listing), notice: 'Listing was created successfully!' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize @listing, :show?
  end

  def edit
    authorize @listing, :edit?
  end

  def update
    authorize @listing, :update?
    @listing.owner = current_user

    respond_to do |format|
      if @listing.update(listing_params)
        current_user.add_role(:owner, @listing)
        format.html { redirect_to @listing, notice: 'Listing has been updated!' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @listing, :destroy?
    respond_to do |format|
      if @listing.destroy
        format.html { redirect_to listings_path, notice: 'Listing was successfully deleted!' }
        format.json { head :no_content }
      else
        flash.now[:notice] = 'Listing was not destroyed.'
      end
    end
  end

  def add_picture
    @listing = Listing.find params[:id]
    @picture = @listing.pictures.create(image: params[:file])
    @picture.save
  end

  private

    def listing_params
      params.require(:listing).permit(
        :name,
        :bedrooms,
        :beds,
        :bathrooms,
        :property_type,
        :city,
        :state,
        :address,
        :lat,
        :lng,
        :description,
        :amenities => []
      )
    end

    def set_listing
      @listing = Listing.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = 'That listing does not appear to exist.'
      redirect_to listings_path
    end
end
