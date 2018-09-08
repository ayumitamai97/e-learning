class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @lessons = Lesson.all
    @categories = Category.all
  end

  def show
    lesson_id = params[:id].to_i
    @category_id = Lesson.find(lesson_id).category_id
    @category_title = Category.find(@category_id).title
    @words = Category.find(@category_id).words
  end
  
  def new
    @lesson = Lesson.new(user_and_cat_params)
    @category_id = params[:category_id].to_i
    @category_title = Category.find(@category_id).title
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @category_id = params[:category_id].to_i
    @category_title = Category.find(@category_id).title

    word_ids = Category.find(@category_id).words.map(&:id)
    answered_word_ids = WordAnswer.where(user_id: current_user.id, category_id: @category_id).map(&:word_id).uniq
    remaining_words = Category.find(@category_id).words.where.not(id: answered_word_ids)

    if remaining_words.blank?
      redirect_to lessons_path, flash: { notice: "You have already done the requested lesson." }
      return
    end

    @lesson.save

    words = Category.find(@category_id).words
    word = words.first

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
