class Micropost < ApplicationRecord
  belongs_to :carid
  validates :carid_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :kind,    presence: true
end
