class Post < ActiveRecord::Base
  #mount_uploader :picture, ImageUploader
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  default_scope { order('rank DESC') }
     scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }
  
  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  after_create :create_vote

  def up_votes
    self.votes.where(value: 1).count #counts the number of positive votes
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    [up_votes, down_votes*-1].sum
    #self.votes.sum(:value).to_i
  end

  def update_rank
     age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
     new_rank = points + age_in_days
     self.update_attribute(:rank, new_rank)
  end

  private
  def create_vote
    user.votes.create(value: 1, post: self)
  end
end
