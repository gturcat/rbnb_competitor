class FlatsController < ApplicationController

  def list
    @show_my_flats = params[:address].nil? & params[:capacity].nil?

    if @show_my_flats
      @flats = Flat.where(user: current_user)
    else
      @flats = Flat.all
      @flats = @flats.near(params[:address], 10) if params[:address] != ""
      @flats = @flats.where("capacity >= #{params[:capacity]}") if params[:capacity] != ""
    end
    authorize @flats

    @flat_to_locate = @flats.where.not(latitude: nil, longitude: nil)

    @markers = @flat_to_locate.map do |flat|
      {
        lng: flat.longitude,
        lat: flat.latitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { flat: flat })
      }
    end
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def create
    @flat = Flat.new(flat_params)
    authorize @flat
    @flat.user = current_user
    if @flat.save
      redirect_to flats_list_path
    else
      render :new
    end
  end

  def edit
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def update
    @flat = Flat.find(params[:id])
    authorize @flat
    @flat.update(flat_params)
    redirect_to flats_list_path
  end

  def destroy
    @flat = Flat.find(params[:id])
    authorize @flat
    @flat.destroy
    redirect_to flats_list_path
  end

  private

  def flat_params
    params.require(:flat).permit(:address, :title, :description, :capacity, :price, :photo)
  end
end
