class Food < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :measurement_unit, presence: true, inclusion: { in: %w[gram ounce liter kg pound] }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :user
  has_many :recipe_foods
end
