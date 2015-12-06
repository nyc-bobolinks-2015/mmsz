class QuestionsController < ApplicationController
  include QuestionsHelper

  def index
    mode = params[:query] || "latest"
    mode == "latest" ? @questions = Question.latest : @questions = Question.greatest
    # @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)


    if @question.save
      if params[:tag_names]
        tags = create_new_tags(params[:tag_names], @question)
      end
      redirect_to questions_path
    else
      @errors = @question.errors.full_messages
      render :'questions/new'
    end
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:id])
    @question.assign_attributes(question_params)
    if @question.save
      redirect_to question_path(@question)
    else
      @errors = @question.errors.full_messages
      render :'questions/edit'
    end
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answers = Answer.where(question_id: @question.id)
    @answers = @answers.sort_by{|answer| -answer.vote_count}
  end

  def destroy
    question = Question.find_by(id: params[:id])
    question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body).merge(user_id: current_user.id)
  end

end
