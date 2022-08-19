class Public::MoviesController < ApplicationController
    
    def new
      @movie = Movie.new
    end
    
    def create
      @movie = Movie.new(movie_params)
      @movie.user_id = current_user.id
      @movie.save
      redirect_to public_movies_path
    end
    
    def index
    @movie = Movie.all
    end
    
    def show
    @movie = Movie.find(params[:id])
    end
    
    def edit
    @movie = Movie.find(params[:id])
    end
    
    def update
    movie = Movie.find(params[:id])
    movie.update(movie_params)
    redirect_to public_movie_path(movie.id)  
    end
     
    def destroy
    @movie = Movie.find(params[:id])  
    @movie.destroy
    redirect_to public_movies_path 
    end
  
private
 def movie_params
  params.require(:movie).permit(:title, :body, :user_id)
 end 
    
end
