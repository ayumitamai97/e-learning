class Category < ApplicationRecord
  has_many :words
  validates :title, presence: true
end
