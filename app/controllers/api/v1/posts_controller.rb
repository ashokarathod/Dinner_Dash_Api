class Api::V1::PostsController < ApplicationController
  
  before_action :find_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: {error: "unable to create a post"}, status: 400
    end
  end

  def update
    if @post
      @post.update(post_params)
      render json: @post
    else
      render json: {error: "unable to update a post"}
    end
  end

  def destroy
    if @post
      @post.destroy
      render json: {message: "successfully deleted"}, status: 200
    else
      render json:{error: "unable to delete.."}, status: 400
    end
  end

  private 
  
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:post, :likes, :user_id)
  end

end
