class Micropost < ApplicationRecord
  belongs_to :carid
  validates :content, presence: true, length: { maximum: 140 }
  validates :kind,    presence: true
  validates :lat,     presence: true
  validates :lng,     presence: true
  validates :logtime, presence: true
  validates :carid_id,  presence: true
  validates :accuracy,  presence: true, numericality:{ maximum: 500 }
end
