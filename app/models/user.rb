class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_destroy :check_if_last_admin

  validates :name, presence: true, uniqueness: true, length: { in: 4..15 }
  validates :password, presence: true, length: { in: 6..12 }

  def self.admin?
    self.admin
  end

  def check_if_last_admin
    if self.admin? && User.where(admin: true).count == 1
      throw(:abort)
    end
  end
end
