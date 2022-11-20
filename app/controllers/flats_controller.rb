class FlatsController < ApplicationController
  before_action :set_flat, only: %i[show edit update destroy]

  # GET /flats or /flats.json
  def index
    if params[:query].present?
      @query = params[:query]
      @flats = Flat.where("name LIKE '%#{params[:query]}%'")
    else
      @flats = Flat.all
    end
  end

  # GET /flats/1 or /flats/1.json
  def show
    token = 'pk.eyJ1IjoibGlicmEwODA5IiwiYSI6ImNsYXA0Z2NtZDB5NHUzcW4wdzhzbHNpcWUifQ.FIdlGM0w7swLkths6Gx2og'
    location = @flat.address.gsub(' ', '%20')
    coordinates_url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{location}.json?access_token=#{token}"
    data = JSON.parse(URI.open(coordinates_url).read)
    center = data['features'][0]['center']
    @image_url = "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/geojson(%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B#{center[0]}%2C#{center[1]}%5D%7D)/#{center[0]},#{center[1]},12/500x300?access_token=#{token}"
  end

  # GET /flats/new
  def new
    @flat = Flat.new
  end

  # GET /flats/1/edit
  def edit; end

  # POST /flats or /flats.json
  def create
    @flat = Flat.new(flat_params)

    respond_to do |format|
      if @flat.save
        format.html { redirect_to flat_url(@flat), notice: "Flat was successfully created." }
        format.json { render :show, status: :created, location: @flat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flats/1 or /flats/1.json
  def update
    respond_to do |format|
      if @flat.update(flat_params)
        format.html { redirect_to flat_url(@flat), notice: "Flat was successfully updated." }
        format.json { render :show, status: :ok, location: @flat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flats/1 or /flats/1.json
  def destroy
    @flat.destroy

    respond_to do |format|
      format.html { redirect_to flats_url, notice: "Flat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_flat
    @flat = Flat.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guests, :picture_url)
  end
end
