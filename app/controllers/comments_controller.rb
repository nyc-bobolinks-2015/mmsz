class CommentsController < ApplicationController

  #Prefer having the form present in DOM but hidden
  def new
    params[:question_id] ? @commentable = Question.find_by(id: params[:question_id]) : @commentable = Answer.find_by(id: params[:answer_id])
    @comment = Comment.new
    request.xhr? ? (render partial:"form",locals:{comment:@comment,commentable:@commentable}) : (render :"new")
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
    source=@answer || @question
    if @comment.save
      if request.xhr?
        render partial:"new_comment",locals:{comment:@comment, source:source}
      else
        redirect_to question_path(@question)
      end
    else
      @errors = @comment.errors.full_messages
      render :'comments/new'
    end
  end

  def edit
    if params[:question_id]
      @commentable = Question.find_by(id: params[:question_id])
    elsif params[:answer_id]
      @commentable = Answer.find_by(id: params[:answer_id])
    end

    @comment = Comment.find_by(id: params[:id])
  end

  def update
    if params[:question_id]
      @question = Question.find_by(id: params[:question_id])
    else
      @answer = Answer.find_by(id: params[:answer_id])
      @question = @answer.question
    end

    @comment = Comment.find_by(id: params[:id])
    @comment.assign_attributes(comment_params)

    if @comment.save
      redirect_to question_path(@question)
    else
      @errors = @comment.errors.full_messages
      render :'comments/edit'
    end
  end

  def destroy
    if params[:question_id]
      @question = Question.find_by(id: params[:question_id])
    elsif params[:answer_id]
      @question = Answer.find_by(id: params[:answer_id]).question
    end

    comment = Comment.find_by(id: params[:id])
    comment.destroy
    redirect_to question_path(@question)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
