class FlatsController < ApplicationController

  def list
    if params.nil?
      @flats = Flat.where(user: current_user)
    else
      @flats = Flat.where(city: params[:city]).where("capacity >= #{params[:capacity]}")
    end
  # attention : ajouter .where(flat.user == current_user) quand devise sera integre
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

