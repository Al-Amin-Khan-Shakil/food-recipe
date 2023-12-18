class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_food

  validates :name, presence: true, length: { maximum: 255 }
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
  validates :public, inclusion: { in: [true, false] }
end
