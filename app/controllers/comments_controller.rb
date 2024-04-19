class CommentsController < ApplicationController
  before_action :set_vtuber
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def edit; end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def set_vtuber
    @vtuber = Vtuber.find(params[:vtuber_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id, vtuber_id: @vtuber.id)
  end
end
