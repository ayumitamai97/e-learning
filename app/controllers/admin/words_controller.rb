class Admin::WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :destroy]
  before_action :authorize

  def index
    @words = Word.all
  end

  def show
  end

  def new
    @word = Word.new(category_params)
  end

  def edit
  end

  def create
    @word = Word.new(word_params)
    category_id = params[:word][:category_id]

    respond_to do |format|
      if @word.save
        format.html { redirect_to "/admin/categories/" + category_id, notice: 'Word was successfully created.' }
      else
        format.html { render action: "new", locals: { category_id: category_id }}
      end
    end
  end

  def update
    @word = Word.find(params[:word][:id]) || Word.find(params[:id])
    category_id = params[:word][:category_id]

    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to admin_words_path, notice: 'Word was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to admin_words_path, notice: 'Word was successfully destroyed.' }
    end
  end

  private
    def set_word
      @word = Word.find(params[:id])
    end

    def word_params
      params.require(:word).permit(:id, :question, :option_1, :option_2, :option_3, :option_4, :answer, :category_id)
    end

    def category_params
      params.permit(:category_id)
    end

    def authorize
      redirect_to root_path unless current_user.admin?
    end
end
