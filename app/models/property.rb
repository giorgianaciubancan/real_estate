class Property < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :account
end
