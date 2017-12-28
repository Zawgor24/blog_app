# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: %i[show edit update destroy like]
  before_action :add_authorize, only: %i[edit update destroy]

  after_action :verify_authorized, only: %i[destroy update edit]

  def index
    @posts = Post.all

    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv }
      format.xls { send_data @posts.to_csv(col_sep: "\t") }
    end
  end

  def show
    @post.increment
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save!
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path
  end

  def like
    if params[:type] == 'Like'
      value = 1
      @post.add_or_update_evaluation(:likes, value, current_user)
    elsif params[:type] == 'Dislike'
      value = 0
      @post.delete_evaluation(:likes, current_user)
    end

    redirect_to @post
  end

  def import
    Post.import(params[:file], current_user)

    redirect_to root_path
  end

  private

  def add_authorize
    authorize @post
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
