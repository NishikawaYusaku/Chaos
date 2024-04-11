class VtuberTag < ApplicationRecord
  belongs_to :vtuber
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :vtuber_id }
end
