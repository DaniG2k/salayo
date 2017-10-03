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
    @listing = Listing.new listing_params
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

  def upload_tmp_images
    params[:file].each do |num, pic|
      File.open(Rails.root.join('public', 'uploads', 'tmp', pic.original_filename), 'wb') do |file|
        file.write(pic.read)
        File.rename(file, "public/uploads/tmp/#{params[:hex]}_uid_#{current_user.id}_#{pic.original_filename}")
      end
    end
    render json: nil, status: :ok
  end

  def rm_tmp_image
    File.delete(Rails.root.join('public', 'uploads', 'tmp', "#{params[:hex]}_uid_#{current_user.id}_#{params[:rm_image]}"))
    render json: nil, status: :ok
  end

  private

    def listing_params
      params.require(:listing).permit(
        :name,
        :property_type,
        :city,
        :state,
        :address,
        :lat,
        :lng,
        :amenities => [],
        :listing_images => []
      )
    end

    def set_listing
      @listing = Listing.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = 'That listing does not appear to exist.'
      redirect_to listings_path
    end
end
