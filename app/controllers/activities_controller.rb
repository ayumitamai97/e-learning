class ActivitiesController < ApplicationController
  def index
    if current_user.nil?
      redirect_to categories_path
      return
    end
    @user = current_user
    following_ids = @user.relationships.where(follower_id: @user.id).map(&:following_id)
    @followings = User.find(following_ids)
  end

  def words_detail
    @users_answers = WordAnswer.eager_load(lesson: { category: :words })
                      .where("word_answers.user_id = #{current_user.id}")
  end
end
