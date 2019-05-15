class PostsController < ApplicationController
  def new
  	@ourpost = Post.new
  end

  def create
  @ourpost = Post.new(create_parameters.merge(user: current_user))
  if @ourpost.save
  redirect_to root_path
end
  end

  def create_parameters
  	params. require(:post).permit(:content)
  end
end