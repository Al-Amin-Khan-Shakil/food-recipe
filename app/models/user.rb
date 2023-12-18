class User < ApplicationRecord
  validates :name, presence: true
  has_many :recipe
  has_many :food
end
