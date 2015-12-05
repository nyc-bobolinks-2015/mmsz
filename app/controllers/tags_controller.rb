class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def search
    @tag = Tag.find_by(name: params[:search_name])
    if @tag
      render "tags/show"
    else
      redirect_to tags_path
    end
  end

end