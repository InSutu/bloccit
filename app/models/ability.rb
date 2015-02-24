#ability.rb
# From Comments checkpoint:  https://github.com/Bloc/rails-tutorial/blob/master/answers.md
   if user.role? :member
      can :manage, Post, :user_id => user.id
      can :manage, Comment, :user_id => user.id
    end
