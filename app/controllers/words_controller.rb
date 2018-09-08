class WordsController < ApplicationController
  before_action :set_category, only: [:show, :update]

  def show
    check_remaining_words
    if @remaining_words.blank? && !@answered_word_ids.blank?
      redirect_to lesson_result_path
    elsif @remaining_words.blank? && @answered_word_ids.blank?
      redirect_to lessons_path
    end
  end

  def update
    word_id = params[:id]
    answer = params[:option]  

    WordAnswer.create(
      user_id: current_user.id,
      category_id: @category_id,
      lesson_id: @lesson_id,
      word_id: word_id,
      answer: answer)

    check_remaining_words
    if @remaining_words.blank?
      redirect_to lesson_result_path(@lesson_id)
    else
      next_word_id = @remaining_words.first.id
      redirect_to lesson_word_path(lesson_id: @lesson_id, id: next_word_id)
    end
  end

  def result
    @category = Lesson.find(params[:lesson_id]).category

    @words = @category.words.order("id")
    @word_answers =  WordAnswer.where(category_id: @category.id).order("word_id")
  end

  private
    def set_category
      @category_id = Word.find(params[:id]).category.id
      @lesson_id = params[:lesson_id]
    end

    def check_remaining_words
      word_ids = Category.find(@category_id).words.map(&:id)
      @answered_word_ids = WordAnswer.where(user_id: current_user.id, category_id: @category_id).map(&:word_id).uniq
      @remaining_words = Category.find(@category_id).words.where.not(id: @answered_word_ids)
    end
end
