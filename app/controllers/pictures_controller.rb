class PicturesController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_picture, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # def index
  #   @pictures = Picture.all
  # end

  # GET /pictures/1
  # GET /pictures/1.json
  # def show
  # end

  # GET /pictures/new
  # def new
  #   @picture = Picture.new
  # end

  # GET /pictures/1/edit
  # def edit
  # end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.listing_id = params[:listing_id]
    @picture.image = params[:file]
    @picture.save!
    render json: @picture
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  # def update
  #   respond_to do |format|
  #     if @picture.update(picture_params)
  #       format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @picture }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @picture.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  # def destroy
  #   @picture.destroy
  #   render nothing: true
  # end

  private

    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(
        :description,
        :image,
        :imageable_type,
        :imageable_id
      )
    end
end
