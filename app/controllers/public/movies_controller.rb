class Public::MoviesController < ApplicationController
    
    def new
      @movie = Movie.new
    end
    
    def create
      @movie = Movie.new(movie_params)
      if @movie.save
      redirect_to public_movies_path
      else
      render :new
      end
    end
    
private
 def movie_params
  params.require(:movie).permit(:title, :body, :user_id)
 end 
    
end
