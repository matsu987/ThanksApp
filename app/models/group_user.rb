class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum rank: { "メンバー": 0, "チームリーダー": 1, "拠点リーダー": 2, "チーム統括": 3, "エリアリーダー": 4, "グループリーダー": 5,
     "ユニットリーダー": 6, "秘書": 7, "内部監査担当者": 8, "新規事業担当者": 9, "代表取締役": 10, "社長": 11, "業務委託": 12, "派遣": 13, "アルバイト": 14 }
  # validates :rank,
  # 　inclusion: {in: GroupUser.ranks.keys}

  enum status: { "一般": 0, "管理者": 1 }

  validates :status, :rank, presence: true
  # validates :status,
  # inclusion: {in: GroupUser.statuses.keys}
end
