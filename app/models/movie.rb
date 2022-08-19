class Movie < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    
    def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/11703.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
    end
  
end
