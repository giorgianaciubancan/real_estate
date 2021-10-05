class Property < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :account
  scope :latest, -> {order created_at: :desc}
end
