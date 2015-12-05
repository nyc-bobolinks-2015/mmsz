require 'rails_helper'

RSpec.describe Vote, type: :model do

  context "associations" do
    it {should belong_to :user}
    it { should belong_to :votable }
  end

  it "should save all fields if question is valid" do
    vote = Vote.new
    vote.user = FactoryGirl.create(:user)
    vote.votable = FactoryGirl.create(:question)
    expect {
      vote.save
    }.to change{vote.id}.from(nil).to be_truthy
  end
end
