class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @questions = @tag.questions
  end

  private

  def tag_params
    params.require(:tags).permit(:name)
  end
end
