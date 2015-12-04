class QuestionsController < ApplicationController
  def index
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to questions_path
    else
      @errors = @question.errors.full_messages
      render :'questions/new'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
