class Vtuber < ApplicationRecord

  mount_uploader :image, ImageUploader

  def self.ransackable_attributes(auth_object = nil)
    ["name", "gender", "like", "unlike"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "contents", "places", "vtuber_contents", "vtuber_places"]
  end
  
  has_many :vtuber_users, dependent: :destroy
  has_many :users, through: :vtuber_users

  has_many :vtuber_places
  has_many :places, through: :vtuber_places

  has_many :vtuber_contents
  has_many :contents, through: :vtuber_contents

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :comments, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  # validates :name_x, uniqueness: true, if: -> { new_record? || changes[:name_x] }

  accepts_nested_attributes_for :vtuber_places, allow_destroy: true

end
