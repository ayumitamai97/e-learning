class Category < ApplicationRecord
  has_many :words
  has_many :lessons

  validates :title, presence: true
end
