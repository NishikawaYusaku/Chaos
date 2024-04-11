class Vtuber < ApplicationRecord

  mount_uploader :image, ImageUploader

  def self.ransackable_attributes(auth_object = nil)
    ["name", "gender", "like", "unlike"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "contents", "places", "tags", "vtuber_contents", "vtuber_places", "vtuber_tags"]
  end
  
  has_many :vtuber_users, dependent: :destroy
  has_many :users, through: :vtuber_users

  has_many :vtuber_places, dependent: :destroy
  has_many :places, through: :vtuber_places

  has_many :vtuber_contents, dependent: :destroy
  has_many :contents, through: :vtuber_contents

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :vtuber_tags, dependent: :destroy
  has_many :tags, through: :vtuber_tags

  has_many :comments, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  # validates :name_x, uniqueness: true, if: -> { new_record? || changes[:name_x] }

  accepts_nested_attributes_for :vtuber_places, allow_destroy: true

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
  
    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(name: old_tag)
    end
  
    new_tags.each do |new_tag|
      vtuber_tag = Tag.find_or_create_by(name: new_tag)
      self.tags << vtuber_tag unless self.tags.exists?(vtuber_tag.id)
    end
  end

end