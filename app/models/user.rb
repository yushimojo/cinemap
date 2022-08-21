class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
         
  has_many :users, dependent: :destroy
  validates :nickname, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 255 }
  
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/12345.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end
  
   
  
end
