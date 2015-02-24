class AddUserToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id
  end
end

#https://github.com/Bloc/rails-tutorial/blob/master/answers.md