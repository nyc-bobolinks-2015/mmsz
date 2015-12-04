class CommentsController < ApplicationController
  def new
    if params[:question_id]
      @commentable = Question.find_by(id: params[:question_id])
    elsif params[:answer_id]
      @commentable = Answer.find_by(id: params[:answer_id])
    end

    @comment = Comment.new
  end

  def create
    if params[:question_id]
      @question = Question.find_by(id: params[:question_id])
      @comment = @question.comments.build(comment_params)
    else
      @answer = Answer.find_by(id: params[:answer_id])
      @comment = @answer.comments.build(comment_params)
      @question = @answer.question
    end

    if @comment.save
      redirect_to question_path(@question)
    else
      @errors = @comment.errors.full_messages
      render :'comments/new'
    end
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
