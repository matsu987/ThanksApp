class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum rank: { "メンバー": 0, "チームリーダー": 1, "拠点統括": 2, "エリア統括": 3, "グループリーダー": 4,
     "ユニットリーダー": 5, "秘書": 6, "内部監査担当者": 7, "新規事業担当者": 8, "新規事業担当者": 9 "代表取締役": 10, "社長": 11 }
  validates :rank,
  inclusion: {in: GroupUser.ranks.keys}
end
