class RecomendComment < ApplicationRecord
  belongs_to :user
  belongs_to :recomendation
end
