class Admin::UsersController < ApplicationController
  before_action :authorize
  before_action :set_user, only: :edit

  def index
    @users = User.all.page(params[:page])
    @current_user_followings = Relationship.where(follower_id: current_user.id).map(&:following_id)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user)
        .permit(:email, :encrypted_password, :reset_password_token, :confirmation_token, :unconfirmed_email, :avatar)
    end

    def authorize
      redirect_to root_path unless current_user.admin?
    end
end
