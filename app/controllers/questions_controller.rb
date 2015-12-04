class QuestionsController < ApplicationController
  include QuestionsHelper

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id

    if params[:tag_names]
      tags = create_new_tags(params[:tag_names])
    end
    if @question.save
      @question.tags = tags
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
