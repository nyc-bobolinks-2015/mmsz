require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "validations" do
    it { should validate_presence_of :body }

    it do
      should validate_length_of(:body).
      is_at_least(1).
      is_at_most(3000)
    end
  end

  context "associations" do
    it {should have_many :comments}
    it {should have_many :votes}
    it {should belong_to :question}
    it {should belong_to :user}
  end

  it "should save all fields if answer is valid" do
    answer = Answer.new
    answer.body = "This is the body for a answer"
    answer.user = FactoryGirl.create(:user)
    answer.question = FactoryGirl.create(:question)

    expect {
      answer.save
    }.to change{answer.id}.from(nil).to be_truthy
  end
end
