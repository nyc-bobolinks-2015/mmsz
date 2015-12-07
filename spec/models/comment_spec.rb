require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validations" do
    it {should validate_presence_of :body}

    it do
      should validate_length_of(:body).
      is_at_least(1).
      is_at_most(3000)
    end
  end

  context "associations" do
    it {should belong_to :commentable}
    it {should belong_to :user}
  end

  it "should save all fields if comment is valid" do
    comment = Comment.new(body: "This is the body")
    comment.user = FactoryGirl.create(:user)
    comment.commentable = FactoryGirl.create(:answer)
    expect {
      comment.save
    }.to change{comment.id}.from(nil).to be_truthy
  end
end

