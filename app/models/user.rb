class User < ApplicationRecord
  has_many :lessons
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :activities

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :current_user

  def admin?
    admin
  end
end
