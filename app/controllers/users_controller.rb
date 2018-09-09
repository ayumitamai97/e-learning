class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user_followings = Relationship.where(follower_id: current_user.id).map(&:following_id)
  end

  def show
    @user = User.find(params[:id]) # page's user
    @user_followings = Relationship.where(follower_id: @user.id).map(&:following_id)
    @user_followers = Relationship.where(following_id: @user.id).map(&:follower_id)

    @current_user_followings = Relationship.where(follower_id: current_user.id).map(&:following_id)
    @current_user_followers = Relationship.where(following_id: current_user.id).map(&:follower_id)
  end

  def follow
    following_id = params[:following_id]
    ActiveRecord::Base.transaction do
      current_user.relationships.create!(follower_id: current_user.id, following_id: following_id)
      current_user.activities.create!(following_id: following_id)
    end
  end

  def unfollow
    following_id = params[:following_id]
    relationship = 
      current_user.relationships.where(follower_id: current_user.id, following_id: following_id).first
    relationship.destroy
    # 普通、unfollowed情報はダッシュボードに出さないですよねー…
  end
end
