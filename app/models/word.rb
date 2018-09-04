class Word < ApplicationRecord
  belongs_to :category
  accepts_nested_attributes_for :category

  validates :question, presence: true
  validates :option_1, presence: true
  validates :option_2, presence: true
  validates :option_3, presence: true
  validates :option_4, presence: true
  validates :answer, presence: true
end
