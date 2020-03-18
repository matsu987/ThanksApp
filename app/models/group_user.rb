class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum rank: { "メンバー": 0, "チームリーダー": 1, "拠点統括": 2, "エリア統括": 3, "グループリーダー": 4, "ユニットリーダー": 5, "社長": 6 }
  validates :rank,
  inclusion: {in: GroupUser.ranks.keys}
end
