require 'rails_helper'

RSpec.describe Question, type: :model do
  context "validations" do
    it { should validate_presence_of :body }
    it { should validate_presence_of :title }
    it { should validate_presence_of :title }
    it do
      should validate_length_of(:title).
      is_at_least(1).
      is_at_most(400)
    end
    it do
      should validate_length_of(:body).
      is_at_least(1).
      is_at_most(400)
    end
  end

  it "should save all fields if question is valid" do
    question = Question.new
    question.title = "What is up?"
    question.body = "This is the body for a question"
    question.user = FactoryGirl.create(:user)

    expect {
      question.save
    }.to change{question.id}.from(nil).to be_truthy
  end
end
