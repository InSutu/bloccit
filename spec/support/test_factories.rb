module TestFactories

  def associated_post(options={})
       #topic = Topic.create(name: 'Topic name')
       #user = authenticated_user
       #post = Post.new(title: 'Post title', body: 'Post bodies must be pretty long.', topic: topic, user: user)
       post_options = {
         title: 'Post title',
         body: 'Post bodies must be pretty long.',
         topic: Topic.create(name: 'Topic name'),
         user: authenticated_user
       }.merge(options)

      #Post.create(title: 'Post title', body: "Post bodies must be pretty long.", user: user, topic: topic)
      Post.create(post_options)
      end

     #def authenticated_user
     def authenticated_user(options={})
       #email = "email#{rand}@fake.com"
       #user = User.new(email: email, password: 'password')
        user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
        user = User.new(user_options)
        user.skip_confirmation!
        user.save
        user
    end
end