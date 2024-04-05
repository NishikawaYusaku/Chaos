class VtuberPlace < ApplicationRecord
  belongs_to :vtuber
  belongs_to :place
  
  # validates :place_id, presence: true
  validates :url, presence: true
end
