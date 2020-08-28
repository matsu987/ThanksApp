class Thank < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :group
  has_many :comments
  has_many :thank_likes

  validates :text, presence: true
end
