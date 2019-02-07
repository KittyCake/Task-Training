class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { in: 1..20 }
  validates :content, presence: true, length: { in: 1..60 }
  validates :priority, inclusion: { in: %w(輕鬆 一般 重要) }
  validate :endtime_cannot_be_in_the_past
  validates :status, presence: true, inclusion: { in: %w(待處理 進行中 完成) }

  def endtime_cannot_be_in_the_past
    if endtime.present? && endtime < Time.now
      errors.add(:endtime, "不能選擇過去時間")
    end
  end
end
