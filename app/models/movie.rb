class Movie < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :movie_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/11703.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
    end
    
    def favorited_by?(user)
    favorites.exists?(user_id: user.id)
    end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @movie = Movie.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @movie = Movie.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @movie = Movie.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @movie = Movie.where("title LIKE?","%#{word}%")
    else
      @movie = Movie.all
  end
end
