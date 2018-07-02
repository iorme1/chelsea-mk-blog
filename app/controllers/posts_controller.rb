class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy, :edit, :update]
  before_action :authorize_user, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = "Blog post successfully created."
      redirect_to @post
    else
      flash[:alert] = "There was an error creating the blog post. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Blog post has been updated."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error updating the blog post. Please try again."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Blog post was deleted."
      redirect_to root_path
    else
      flash[:alert] = "Blog post could not be deleted. Please try again."
      redirect_to root_path
    end
  end
end