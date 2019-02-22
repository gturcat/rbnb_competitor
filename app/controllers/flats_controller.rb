class FlatsController < ApplicationController
  def index # reponse au search
    arrival = params[:start_date].to_date
    departure = params[:end_date].to_date
    @booking = Booking.new(start_date: arrival, end_date: departure)
    @flats = Flat.all
    @flats = policy_scope(Flat).order(created_at: :desc)
    @flats = @flats.near(params[:address], 10) if params[:address] != ""
    @flats = @flats.where("capacity >= #{params[:capacity]}") if params[:capacity] != ""


    @flat_to_locate = @flats.where.not(latitude: nil, longitude: nil)
    @flat_to_locate = @flat_to_locate.reject { |flat| not_available?(flat) }
    @flats = @flat_to_locate
    @markers = @flat_to_locate.map do |flat|
       {
          lng: flat.longitude,
          lat: flat.latitude
        }
      end
  end

  def list
     @flats = Flat.where(user: current_user)
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

  def not_available?(flat)
    available = 0
    if (params[:start_date] !="" && params[:end_date] !="")
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
