require 'rails_helper'

describe Vote do
  describe "#up_vote?" do
    it "returns true for an up vote" do
      v = Vote.new(value: 1)
      v.up_vote?.should be_truthy
    end
    it "returns false for a down vote" do
      v = Vote.new(value: -1)
      v.up_vote?.should be_falsey
    end
  end
end

  describe 'after_save' do
       it "calls `Post#update_rank` after save" do
         post = associated_post
         vote = Vote.new(value: 1, post: post)
         expect(post).to receive(:update_rank)
          vote.save
       end
     end

  describe "#down_vote?" do
    it "returns true for a down vote" do
      v = Vote.new(value: -1)
      v.down_vote?.should be_truthy
    end
    it "returns false for an up vote" do
      v = Vote.new(value: 1)
      v.down_vote?.should be_falsey
    end
  end

  describe "#update_post" do
    it "calls 'update_rank' on post" do
      post = create(:post)
      post.should respond_to(:update_rank)
      post.should_receive(:update_rank)
      Vote.create(value: 1, post: post)
    end
  end


