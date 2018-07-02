class CommentsController < ApplicationController

  before_action :authorize_user, except: [:index]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_to @post
    else
      flash[:alert] = "Comment failed to save. Please try again."
      redirect_to @post
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def update
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.assign_attributes(comment_params)

    if @comment.save
      flash[:notice] = "Comment has been updated."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error updating that comment. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to @post
    else
      flash[:alert] = "Comment couldn't be deleted. Please try again."
      redirect_to @post
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    unless current_user.member? || current_user.admin?
      flash[:alert] = "You must be atleast member to comment. Sign up for free now!"
      redirect_to root_path
    end
  end
end
