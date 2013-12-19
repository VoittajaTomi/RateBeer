class RatingsController < ApplicationController
	def index
	
	@ratings = Rating.all

	end
        
        def new
          
          @rating = Rating.new
          
        end
        
        def create
          #debugger
          #raise
          Rating.create params[:rating]
          redirect_to ratings_path
        end
end
