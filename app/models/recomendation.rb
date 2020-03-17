class Recomendation < ApplicationRecord
  belongs_to :recomender, class_name: 'User'
  belongs_to :electeder, class_name: 'User'
  has_one :recomend_comment
end
