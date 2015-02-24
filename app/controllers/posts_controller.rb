class PostsController < ApplicationController
  def index
    @posts = Post.all
      authorize @posts
  end

  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end


  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
      authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    #@post = Post.new(params.require(:post).permit(:title, :body))
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
      #raise #this will short circuit the method and can be used for debugging
      authorize @post

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end


  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
      authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    #@post = current_user.posts.build(post_params)
      
      authorize @post

    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving your post.  Please try again."
      render :edit
    end
  end

    private
    def post_params
      params.require(:post).permit(:title, :body)
    end

end
