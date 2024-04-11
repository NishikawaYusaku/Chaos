class Tag < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  has_many :vtuber_tags, dependent: :destroy
  has_many :vtubers, through: :vtuber_tags

  validates :name, presence: true, uniqueness: true
end
