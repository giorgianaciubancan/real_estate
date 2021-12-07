class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  scope :active, -> {where(active: true) }
  scope :latest, -> {order created_at: :desc}

end
