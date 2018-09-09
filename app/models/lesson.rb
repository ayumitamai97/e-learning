class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :word_answers
  accepts_nested_attributes_for :category
end
