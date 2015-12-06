class TagsController < ApplicationController
  def index
    mode = params[:query] || "latest"
    mode == "latest" ? @tags = Tag.latest : @tags = Tag.greatest
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def search
    @tag = Tag.find_by(name: params[:search_name].downcase)
    if @tag
      render "tags/show"
    else
      redirect_to tags_path
    end
  end
end