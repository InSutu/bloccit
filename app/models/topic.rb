class Topic < ActiveRecord::Base
  has_many :posts, dependant: :destroy
end
