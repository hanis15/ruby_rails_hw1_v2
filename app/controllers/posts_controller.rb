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

    string_tags = post_params[:tag_strings].split(/ *[, ] */).uniq
    string_tags.each do |tag|
      curr_tag = TagString.where(:name => tag)
      if curr_tag.blank?
        @post.tag_strings.create(:name => tag)
      else
        @post.tag_strings << curr_tag
      end
    end

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
    @post.update_attributes(params.require(:post).permit(:title, :author, :body))
    redirect_to :action => "index"
  end

  def destroy
    @post = Post.find(params[:id])
    all_id_tags = @post.tag_strings.map(&:id)
    all_id_tags.each do |tag_id|
      is_exist = false
      Post.all.each do |curr_post|
        is_exist = true if curr_post.tag_strings.map(&:id).include?(tag_id) && @post[:id] != curr_post[:id]
      end
      TagString.find(tag_id).destroy unless is_exist
    end
    @post.destroy
    redirect_to @post
  end

end
