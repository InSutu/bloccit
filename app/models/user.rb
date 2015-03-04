class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  mount_uploader :avatar, ImageUploader
  has_many :comments
  #https://github.com/Bloc/rails-tutorial/blob/master/answers.md

 def admin?
   role == 'admin'
 end
 
 def moderator?
   role == 'moderator'
 end

 def favorited(post)
   favorites.where(post_id: post.id).first
 end

def voted(post)
  votes.where(post_id: post.id).first

end

end
