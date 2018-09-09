class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :destroy]
  before_action :authorize

  def index
    @categories = Category.all.page(params[:page])
  end

  def show
    @words = @category.words.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_path, notice: 'Category was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @category = Category.find(params[:category][:id]) || Category.find(params[:id])

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_path, notice: 'Category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_path, notice: 'Category was successfully destroyed.' }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:id, :title, :description)
    end

    def authorize
      redirect_to root_path unless current_user.admin?
    end
end
