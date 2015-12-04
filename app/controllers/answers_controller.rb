class AnswersController < ApplicationController
  def new
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.new
  end

  def create
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question_id = params[:question_id]
    @answer.user_id = current_user.id

    if @answer.save
      redirect_to question_path(@question)
    else
      @errors = @answer.errors.full_messages
      render :'answers/new'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
