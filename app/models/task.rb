class Task < ApplicationRecord
  belongs_to :user
  paginates_per 10
  acts_as_taggable_on :tags

  STATUSES = %w(待處理 進行中 完成)
  PRIORITIES = %w(高 中 低)

  validates :title, presence: true, length: { in: 1..20 }
  validates :content, presence: true, length: { in: 1..60 }
  validates :priority, inclusion: { in: PRIORITIES }
  validate :endtime_cannot_be_in_the_past
  validates :status, presence: true, inclusion: { in: STATUSES }

  def endtime_cannot_be_in_the_past
    if endtime.present? && endtime < Time.now
      errors.add(:endtime, "不能選擇過去時間")
    end
  end
end
