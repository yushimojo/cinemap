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
  has_many :followings, through: :relationships, source: :follower
  
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following
  
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end 
  
  
    
 
  validates :nickname, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 255 }
  
  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/12345.jpeg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
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
