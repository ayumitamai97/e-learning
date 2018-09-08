class Admin::LessonsController < ApplicationController
  before_action :authorize

  def index
    @users = User.all
  end

  def show
    # show each lesson
  end

  private
    def authorize
      redirect_to root_path unless current_user.admin?
    end
end
