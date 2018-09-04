class User < ApplicationRecord
  has_many :lessons

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
