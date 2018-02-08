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
    @listing = Listing.new(JSON.parse(params[:listing]))
    @listing.owner = current_user
    @listing.pictures = params[:file].values.map {|file| Picture.new(image: file)}

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

    respond_to do |format|
      if params[:file].nil?
        # Use the normal update method since no images were uploaded.
        if @listing.update(listing_params)
          format.html { redirect_to @listing, notice: 'Listing has been updated!' }
          format.json { render :show, status: :ok, location: @listing }
        else
          format.html { render :edit }
          format.json { render json: @listing.errors, status: :unprocessable_entity }
        end
      else
        # Append images and new data to @listing
        if @listing.update_attributes(JSON.parse(params[:listing]))
          @listing.pictures << params[:file].values.map {|file| Picture.new(image: file)}
          format.json { render :show, status: :ok, location: @listing }
        else
          format.json { render json: @listing.errors, status: :unprocessable_entity }
        end
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
