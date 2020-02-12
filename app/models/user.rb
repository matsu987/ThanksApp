class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users
  has_many :grops, through: :group_users
  has_many :sended_thnks, class_name: 'Thanks', foreign_key: 'sender_id'
  has_many :received_thanks, class_name: 'Thanks', foreign_key: 'receiver_id'

  # 先頭は文字列から始まり、末尾は@di-v.co.jpの形のemailを許可
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@di-v.co.jp\z/
  # ６文字以上の半角英数字を許可
  VALID_PASSWORD_REGEX = /\A[a-z0-9]{6,}/i

  validates :name, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX }
  validates :password, format: {with: VALID_PASSWORD_REGEX }
  # president:　社長, ul: ユニットリーダー, gl:グループリーダー
  # bl: エリア統括, sbl: 拠点統括, tl: チームリーダー, mem: メンバー
  enum rank: { "代表": 0, "ユニットリーダー": 1, "グループリーダー": 2, "エリア統括": 3, "拠点統括": 4, "チームリーダー": 5, "メンバー": 6 }
end
