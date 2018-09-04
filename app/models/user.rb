class User < ApplicationRecord
  has_many :lessons

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  attr_accessor :current_user

  def admin?
    admin
  end
end
