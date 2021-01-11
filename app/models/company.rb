class Company < ApplicationRecord
  has_many :groups
  validates :name, uniqueness: true, presence: true
  # mount_uploader :logo, ImageUploader
end
