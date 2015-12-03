class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    #render plain: params[:post].inspect
    post_params = params[:post]
    @post = Post.new(:title => post_params[:title], :author => post_params[:author], :body => post_params[:body])
    @post.save
    @post.tag_strings.create(:name => post_params[:tag_strings])
    @post.save
    redirect_to @post
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tag_strings.map {|c| c.name}.join(', ')
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to @post
  end

end
