class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @lessons = current_user.lessons
    @categories = Category.all.page(params[:page])
  end

  def show
    lesson = Lesson.find(params[:id])
    @category = lesson.category
    @words = Category.find(@category.id).words
    @word_answers = WordAnswer.where(category_id: @category.id).order("word_id")
    @user = lesson.user
  end
  
  def new
    @lesson = Lesson.new(user_and_cat_params)
    @category_id = params[:category_id].to_i
    @category_title = Category.find(@category_id).title
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if lesson = Lesson.find_by(category_id: @lesson.category_id, user_id: @lesson.user_id)
      @lesson = lesson
    end

    @category_id = params[:category_id].to_i
    @category_title = Category.find(@category_id).title

    word_ids = Category.find(@category_id).words.map(&:id)
    answered_word_ids = WordAnswer.where(user_id: current_user.id, category_id: @category_id).where("answer IS NOT NULL").map(&:word_id).uniq
    #TODO: scope
    remaining_words = Category.find(@category_id).words.where.not(id: answered_word_ids)

    if remaining_words.blank?
      redirect_to lessons_path, flash: { notice: "You have already done the requested lesson." }
      return
    end

    ActiveRecord::Base.transaction do
      @lesson.save!
      current_user.activities.create!(lesson_id: @lesson.id)
    end

    word = remaining_words.first
    redirect_to lesson_word_path(lesson_id: @lesson.id, id: word.id)
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def user_and_cat_params
      params.permit(:user_id, :category_id)
    end

    def lesson_params
      params.permit(:user_id, :category_id)
    end
end
