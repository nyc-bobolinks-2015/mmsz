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
      is_at_most(3000)
    end
  end

  context "associations" do
    it {should have_many :answers}
    it {should have_many :comments}
    it {should have_many :votes}
    it {should belong_to :user}
    it { should have_and_belong_to_many(:tags) }
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

  context ".added_today" do
    it "should return all questions added today" do
      q1 = FactoryGirl.create(:question)
      q2 = FactoryGirl.create(:question)
      q3 = FactoryGirl.create(:question)

      expect(Question.added_today).to eq([q1, q2, q3])
    end

    it "should return all questions added this week" do
      q1 = FactoryGirl.create(:question)
      q2 = FactoryGirl.create(:question)
      q3 = FactoryGirl.create(:question)

      expect(Question.added_this_week).to eq([q1, q2, q3])
    end
  end
end
