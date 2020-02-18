class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users
  has_many :groups, through: :group_users
  has_many :sended_thanks, class_name: 'Thank', foreign_key: 'sender_id'
  has_many :received_thanks, class_name: 'Thank', foreign_key: 'receiver_id'

  # president: 社長, ul: ユニットリーダー, gl:グループリーダー
  # bl: エリア統括, sbl: 拠点統括, tl: チームリーダー, mem: メンバー
  enum rank: { "社長": 0, "ユニットリーダー": 1, "グループリーダー": 2, "エリア統括": 3, "拠点統括": 4, "チームリーダー": 5, "メンバー": 6 }
  enum status: { "社員": 0, "管理者":1 }


  # 先頭は文字列から始まり、末尾は@di-v.co.jpの形のemailを許可
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@di-v.co.jp\z/
  # ６文字以上の半角英数字を許可
  VALID_PASSWORD_REGEX = /\A[a-z0-9]{6,}/i

  validates :name, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX }
  validates :password, format: {with: VALID_PASSWORD_REGEX }, on: :create
  # 指定された値がenumのkeyだった場合は許可
  validates :rank,
  inclusion: {in: User.ranks.keys}

  # 指定された値がenumのkeyだった場合は許可
  validates :status,
  inclusion: {in: User.statuses.keys}
end
