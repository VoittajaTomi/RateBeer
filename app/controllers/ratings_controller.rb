class RatingsController < ApplicationController
  
  before_filter :ensure_that_signed_in, :except => [:index, :show]
  
	def index

	@ratings = Rating.all
        @recent = Rating.recent
        @raters = User.best_raters(3)
        @beststyles = Style.top(3)
        @bestbeers = Beer.top(3)
        @bestbreweries = Brewery.top(3)
        

	end

        def new

          @rating = Rating.new
          @beers = Beer.all

        end

        def create
          #debugger
          #raise
          rating = Rating.create params[:rating]

          current_user.ratings << rating

          #session[:last_rating] = "#{Beer.find(params[:rating][:beer_id])} (#{params[:rating][:score]} points)"
          redirect_to user_path current_user
        end

        def destroy

          rating = Rating.find params[:id]
          rating.delete if current_user == rating.user
          redirect_to :back

        end

end
