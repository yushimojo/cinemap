class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
         
  has_many :movies, dependent: :destroy
   has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, foreign_key: :following_id
  has_many :reverse_of_relationships, class_name: 'relationship', foreign_key: :follower_id
 
  validates :nickname, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 255 }
  
  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/12345.jpeg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("nickname LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("nickname LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("nickname LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("nickname LIKE?","%#{word}%")
    else
      @user = User.all
    end
  
  end
  
   def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲストユーザー"
      user.age = 20
      user.gender = "男性"
    end
   end
end
