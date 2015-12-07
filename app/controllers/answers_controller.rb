class AnswersController < ApplicationController
  def new
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.new
  end

  def create
    @question = Question.find_by(id: params[:question_id])
    @answer = @question.answers.build(answer_params)

    if @answer.save
      if request.xhr?
        render partial: "questions/answer_body", locals: {answer: @answer, question: @question}
      else
        redirect_to question_path(@question)
      end
    else
      # What if this was xhr?
      @errors = @answer.errors.full_messages
      render :'answers/new'
    end
  end

  def edit
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.find_by(id: params[:id])
    @answer.assign_attributes(answer_params)

    if @answer.save
      redirect_to question_path(@question)
    else
      @errors = @answer.errors.full_messages
      render :'answers/edit'
    end
  end

  def destroy
    @question = Question.find_by(id: params[:question_id])
    answer = Answer.find_by(id: params[:id])
    answer.destroy

    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body).merge(user_id: current_user.id)
  end
end
