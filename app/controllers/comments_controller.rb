class CommentsController < ApplicationController
  
def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @topic = @post.topic
    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    respond_to do |format|
      format.html {redirect_to [@topic, @post]}
      format.js
    end
  end

# REPLACED BY CREATING WITH AJAX CHECKPOINT
  # def create
  #   @topic = Topic.find(params[:topic_id])
  #   @post = @topic.posts.find(params[:post_id])
  #   @comments = @post.comments

  #   @comment = current_user.comments.build(comment_param)
  #   @comment.post = @post

  #   #authorize! :create, @comment, message: "You need to be signed in to do that."
  #    authorize @comment
  #     if @comment.save
  #       #flash[:notice] = "Comment was created."
  #       redirect_to [@topic, @post], notice: "Comment was created."

  #     else
  #       flash[:error] = "There was an error saving your post."
  #       render :new
  #     end
  #   end



   def destroy
     @post = Post.find(params[:post_id])
     @topic = @post.topic
     @comment = @post.comments.find(params[:id])
 
     authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       #redirect_to [@topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       #redirect_to [@topic, @post]
     end

       respond_to do |format| #UJS - AJAX for Ajax checkpoint
       format.html
       format.js
     end
   end
   

   private
   def comment_params
    params.require(:comment).permit(:body)
  end


end
