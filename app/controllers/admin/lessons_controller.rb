class Admin::LessonsController < ApplicationController
  before_action :authorize

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    @lessons = @user.lessons
  end

  def show
    # show each lesson
  end

  private
    def authorize
      redirect_to root_path unless current_user.admin?
    end
end
