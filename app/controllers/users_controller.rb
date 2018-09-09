class UsersController < ApplicationController
  def index
    @users = User.all
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
    current_user.active_relationships.create!(follower_id: current_user.id, following_id: following_id)
  end

  def unfollow
    following_id = params[:following_id]
    relationship = 
      current_user.active_relationships.where(follower_id: current_user.id, following_id: following_id).first
    relationship.destroy
  end
end
