class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sended_thnks, class_name: 'Thanks', foreign_key: 'sender_id'
  has_many :received_thanks, class_name: 'Thanks', foreign_key: 'receiver_id'
end
