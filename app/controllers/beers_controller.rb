class BeersController < ApplicationController

  before_filter :ensure_that_signed_in, :except => [:index, :show, :list]
  #caches_action :index

  # GET /beers
  # GET /beers.json
  #expire_fragment :controller => :beers, :action => :index
 
  
  
  def list
   
 end
  
def index
    @order = params[:order] || 'name'
@beers = Beer.all(:include => [:brewery, :style]).sort_by{ |b| b.send(@order) }

  respond_to do |format|
    format.html # index.html.erb
    format.json { render :json => @beers, :methods => [ :brewery, :style ] }
  end
end

  # GET /beers/1
  # GET /beers/1.json
def show
  @beer = Beer.find(params[:id])
  @rating = Rating.new
  @rating.beer = @beer    

  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @beer }
  end
end

  # GET /beers/new
  # GET /beers/new.json
  def new
    @beer = Beer.new
    @breweries = Brewery.all
    @styles = Style.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/1/edit
  def edit
    @styles = Style.all
    @beer = Beer.find(params[:id])
    @breweries = Brewery.all
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(params[:beer])
      ["beers-name", "beers-brewery", "beers-style"].each{ |f| expire_fragment(f) } 

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render json: @beer, status: :created, location: @beer }
      else
        format.html { render action: "new" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beers/1
  # PUT /beers/1.json
  def update
      ["beers-name", "beers-brewery", "beers-style"].each{ |f| expire_fragment(f) } 
    @beer = Beer.find(params[:id])

    respond_to do |format|
      if @beer.update_attributes(params[:beer])
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
      ["beers-name", "beers-brewery", "beers-style"].each{ |f| expire_fragment(f) } 
    @beer = Beer.find(params[:id])
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end
end
