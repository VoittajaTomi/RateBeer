class PlacesController < ApplicationController
  
  #include BeermappingAPI
  
  def index
  end

  def show
    #@place = Place.find(params[:id])
    @place = BeermappingAPI.fetch_locquery(params[:id])
    @score = BeermappingAPI.fetch_score(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end  
  
  def search
    @places = BeermappingAPI.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, :notice => "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end