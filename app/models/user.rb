class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :vtuber_users
  has_many :vtubers, through: :vtuber_users

  has_many :favorites, dependent: :destroy
  has_many :favorite_vtubers, through: :favorites, source: :vtuber

  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { self[:password].present? && (new_record? || changes[:crypted_password]) }
  validates :name, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates_acceptance_of :agreement, allow_nil: false, on: :create
end
