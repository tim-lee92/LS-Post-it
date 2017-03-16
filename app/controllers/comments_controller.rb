class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    # @comment = @post.comments.buld(params.require(:comment).permit(:body)) # Same as lines 5-6
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post_id = params[:post_id]

    @comment.creator = current_user

    if @comment.save
      flash['notice'] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
    if vote.valid?
      flash['notice'] = "Your vote was counted."
    else
      flash['error'] = "You have already voted on this."
    end
    redirect_to :back
  end
end
