class FavoritesController < ApplicationController

   def destroy
     @post = Post.find(params[:post_id])
     @topic = @post.topic
     #favorite = Favorite.find(params[:id])
     favorite = Favorite.where(post_id: params[:post_id], user_id: current_user.id).first
     authorize favorite
     # Get the post from the params
     # Find the current user's favorite with the ID in the params
   
     if favorite.destroy
      flash[:notice] = "Your post is no longer a favorite."
      redirect_to :back
     else
       flash[:error] = "You are a jerk - get out of here."
       redirect_to [@topic,@post]# Flash error and redirect to @post
     end
   end
   
     def create
     @post = Post.find(params[:post_id])
     @topic = @post.topic
     favorite = current_user.favorites.build(post: @post)
     authorize favorite
 
     if favorite.save
       
       flash[:notice] = "Your post is now a favorite"
       redirect_to :back
       # Add code to generate a success flash and redirect to @post
       # Remember the path shortcut: [@post.topic, @post]
     else
       flash[:error] = "Something went wrong - try again."
       redirect_to [@topic,@post]# Flash error and redirect to @post
     end
   end
end
