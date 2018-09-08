class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to admin_root_path if current_user && current_user.admin?
    @categories = Category.all
  end

  def show
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end
end
