class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  #attr_accessible :body, :post

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails
 
   private
 
   def send_favorite_emails
     post.favorites.each do |favorite|
       FavoriteMailer.new_comment(favorite.user, post, self).deliver
     end
   end
end
# Comments checkpoint:  https://github.com/Bloc/rails-tutorial/blob/master/answers.md
