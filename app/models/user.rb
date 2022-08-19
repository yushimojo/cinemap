class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :users, dependent: :destroy
  validates :nickname, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 255 }
end
