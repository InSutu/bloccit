class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  scope :visible_to, -> { where(public: true) }
end
