class ActivitiesController < ApplicationController
  def index
    @user = current_user
    following_ids = @user.relationships.where(follower_id: @user.id).map(&:following_id)
    @followings = User.find(following_ids)
  end
end
