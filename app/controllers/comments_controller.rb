class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(comment_param)
    @comment.post = @post

    #authorize! :create, @comment, message: "You need to be signed in to do that."
     authorize @comment
      if @comment.save
        #flash[:notice] = "Comment was created."
        redirect_to [@topic, @post], notice: "Comment was created."

      else
        flash[:error] = "There was an error saving your post."
        render :new
      end
    end



   def destroy
     @topic = Topic.find(params[:topic_id])
     @post = @topic.posts.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
 
     authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       redirect_to [@topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       redirect_to [@topic, @post]
     end
   end
   

   private
   def comment_param
    params.require(:comment).permit(:body)
  end


end
