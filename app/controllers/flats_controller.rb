class FlatsController < ApplicationController

 def list
   if params[:city].nil? & params[:capacity].nil?
     @flats = Flat.where(user: current_user)
   else
     @flats = Flat.all
     @flats = @flats.where(city: params[:city]) if params[:city] != ""
     @flats = @flats.where("capacity >= #{params[:capacity]}") if params[:capacity] != ""
   end
   @flats = @flats.where.not(latitude: nil, longitude: nil)

    @markers = @flats.map do |flat|
      {
        lng: flat.longitude,
        lat: flat.latitude
      }
    end
 end



  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = User.last
    if @flat.save
      redirect_to flats_list_path
    else
      render :new
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:country, :city, :street, :street_number, :zip_code, :title, :description, :capacity, :price, :photo)
  end

end

