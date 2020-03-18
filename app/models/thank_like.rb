class ThankLike < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :thank
end
