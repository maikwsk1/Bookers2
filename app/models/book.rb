class Book < ApplicationRecord
  belongs_to :user
  
 validates :title, presence: { message: "Custom title error message" }
  validates :body, presence: { message: "Custom body error message" }, length: { maximum: 200 }

  
   has_one_attached :image
   
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
