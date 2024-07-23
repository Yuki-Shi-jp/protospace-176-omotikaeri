class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    redirect_to prototype_comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
