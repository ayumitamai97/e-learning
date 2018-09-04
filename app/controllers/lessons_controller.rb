class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
    @categories = Category.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    lesson_id = params[:id].to_i
    @category_id = Lesson.find(lesson_id).category_id
    @category_title = Category.find(@category_id).title
    @words = Category.find(@category_id).words[0] #TODO: wordごとにページ切り替え # まずは最初のquestion
  end
  
  # GET /lessons/new
  def new
    @lesson = Lesson.new(user_and_cat_params)
    @category_id = params[:category_id].to_i
    @category_title = Category.find(@category_id).title
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)
    @category_id = params[:lesson][:category_id].to_i
    @category_title = Category.find(@category_id).title

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_and_cat_params
      params.permit(:user_id, :category_id)
    end

    def lesson_params
      params.require(:lesson).permit(:user_id, :category_id)
    end
end
