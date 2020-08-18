class Company < ApplicationRecord
  has_many :groups
  # mount_uploader :logo, ImageUploader
end
