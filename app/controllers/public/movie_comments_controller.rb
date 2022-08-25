class Public::MovieCommentsController < ApplicationController
    def create
    movie = Movie.find(params[:movie_id])
    comment = current_user.movie_comments.new(movie_comment_params)
    comment.movie_id = movie.id
    comment.save
    redirect_to public_movie_path
  end
  
  def destroy
    MovieComment.find(params[:id]).destroy
    redirect_to public_movie_path(params[:movie_id])
  end

  private

  def movie_comment_params
    params.require(:movie).permit(:comment)
  end
end
