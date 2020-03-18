class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :company
  has_ancestry
end
