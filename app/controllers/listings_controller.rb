class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: %i[show edit update destroy]
  before_action :set_currency_options, only: %i[new edit create]
  layout 'dashboard'

  def index
    @listings = Listing.where.not(owner: current_user.id)
  end

  def mine
    @listings = current_user.listings
  end

  def new
    @listing = Listing.new
    @listing.build_amenity_list

    authorize @listing, :new?
  end

  def create
    @listing = Listing.new params_hash
    @listing.owner = current_user
    @listing.pictures = params[:file].values.map { |file| Picture.new(image: file) } if params[:file].present?

    authorize @listing, :create?

    respond_to do |format|
      if @listing.save
        flash[:notice] = 'Listing was created successfully.'
        format.html { redirect_to listing_path(@listing) }
        format.json { render :show, status: :created, location: @listing }
      else
        flash[:error] = 'Listing has not been created.'
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize @listing, :show?
    @owner = @listing.owner
    @amenity_list_attributes = @listing.amenity_list.attributes.except(
      'id', 'listing_id', 'created_at', 'updated_at'
    )
  end

  def edit
    authorize @listing, :edit?
  end

  def update
    authorize @listing, :update?

    respond_to do |format|
      if @listing.update(params_hash)
        @listing.pictures << params[:file].values.map { |file| Picture.new(image: file) } if params[:file].present?
        flash[:notice] = 'Listing has been updated successfully.'
        format.html { redirect_to @listing }
        format.json { render :show, status: :ok, location: @listing }
      else
        flash[:error] = 'Listing has not been created.'
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @listing, :destroy?
    respond_to do |format|
      if @listing.destroy
        format.html { redirect_to my_listings_path, notice: 'Listing was successfully deleted.' }
        format.json { head :no_content }
      else
        flash.now[:notice] = 'Listing was not destroyed.'
      end
    end
  end

  private

  def params_hash
    # Dropzone will return a stringified JSON object
    if params[:listing].is_a?(String)
      JSON.parse(params[:listing])
    else
      listing_params
    end
  end

  def listing_params
    params.require(:listing).permit(
      :name,
      :bedrooms,
      :beds,
      :bathrooms,
      :price_cents,
      :price_currency,
      :property_type,
      :city,
      :state,
      :address,
      :lat,
      :lng,
      :description,
      amenity_list_attributes: %i[
        id
        air_conditioning
        intercom
        cable_tv
        doorman
        dryer
        elevator
        essentials
        gym
        hair_dryer
        hangers
        heating
        hot_tub
        internet
        iron
        kitchen
        parking
        pool
        refrigerator
        tv
        washer
      ]
    )
  end

  def set_currency_options
    @currency_options = [
      ['€ - EUR', 'eur'],
      ['£ - GBP', 'gbp'],
      ['$ - USD', 'usd'],
      ['¥ - JPY', 'jpy'],
      ['₩ - KRW', 'krw']
    ]
  end

  def set_listing
    @listing = Listing.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = 'That listing does not appear to exist.'
    redirect_to listings_path
  end
end
