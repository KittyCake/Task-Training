class User < ApplicationRecord
  has_many :tasks

  validates :name, presence: true, uniqueness: true, length: { in: 4..15 }
  validates :password, presence: true, length: { in: 6..12 }
end
