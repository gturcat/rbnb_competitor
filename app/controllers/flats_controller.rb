class FlatsController < ApplicationController

  def list
   @show_type = params[:address].nil? & params[:capacity].nil?
   if @show_type
     @flats = Flat.where(user: current_user)
   else
     @flats = Flat.all
     @flats = @flats.near(params[:address], 10) if params[:address] != ""
     @flats = @flats.where("capacity >= #{params[:capacity]}") if params[:capacity] != ""
   end

    @flat_to_locate = @flats.where.not(latitude: nil, longitude: nil)
    @flat_to_locate = @flat_to_locate.reject { |flat| not_available?(flat) }
    @flats = @flat_to_locate
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
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flats_list_path
    else
      render :new
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:address, :title, :description, :capacity, :price, :photo)
  end

  def not_available?(flat)
    available = 0
    if (params[:start_date] != "" && params[:end_date] !="")
    period = params[:start_date].to_date..params[:end_date].to_date
    flat.bookings.each do |booking|
      non_available_period = booking.start_date..booking.end_date
      period.each do |day|
        available +=1 if non_available_period.include?(day)
        end
      end
    end
    available > 0 ? true : false
    end
end
