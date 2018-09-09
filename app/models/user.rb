class User < ApplicationRecord
  has_many :lessons
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :activities

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  mount_uploader :avatar, AvatarUploader
  attr_accessor :current_user

  def admin?
    admin
  end

  def finished_lesson?(user_id: current_user.id, category_id:)
    User.find(user_id).lessons
      .where(category_id: category_id)
      .map{|lesson| lesson.word_answers.count == lesson.category.words.count }
      .first # array contents count should be zero or one
  end
end
