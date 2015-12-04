class AnswersController < ApplicationController
  def new
    @question = params[:question_id]
    @answer = Answer.new
  end

  def create
  end

  private

  def answer_params
end
