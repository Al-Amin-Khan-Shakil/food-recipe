class User < ApplicationRecord
  validates :name, presence: true
  has_many :recipes
  has_many :foods
end
