class PlacesController < ApplicationController
  # before_action :set_session, only: [:show, :index, :search]

  def index
  end

  def show
    @places = BeermappingApi.locquery(params[:id])
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, :notice => "No locations in #{params[:city]}"
    else
      render :index
    end
  end

    # private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_session
    #   session[:places_id] = @places[:id]
    # end
end