require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    it do
      should validate_length_of(:username).
      is_at_least(1).
      is_at_most(40)
    end
  end

  context "associations" do
    it {should have_many :comments}
    it {should have_many :questions}
    it {should have_many :answers}
    it {should have_many :votes}
  end

  it "should save all fields if answer is valid" do
    user = User.new(username: "sam", password: "12345", email: "sam@example.com")

    expect {
      user.save
    }.to change{user.id}.from(nil).to be_truthy
  end

  context "#top_three_tags" do
    it "should get the top three tags for a user" do
      user = FactoryGirl.create(:user)
      q = user.questions.create(title: "Question Title", body: "Question Body")
      tag1 = q.tags.new(name: "tag 1")
      tag2 = q.tags.new(name: "tag 2")
      tag3 = q.tags.new(name: "tag 3")
      expect(user.top_three_tags).to eq(["tag 1", "tag 2", "tag 3"])
    end
  end

  context "#recent_three_questions" do
    it "should return a users most recent 3 questions" do
      user = FactoryGirl.create(:user)
      q1 = FactoryGirl.create(:question, user: user)
      q2 = FactoryGirl.create(:question, user: user)
      q3 = FactoryGirl.create(:question, user: user)

      expect(user.recent_three_questions).to eq([q3,q2,q1])
    end
  end

  context "#recent_three_questions" do
    it "should return a users most recent 3 answers" do
      user = FactoryGirl.create(:user)
      q = FactoryGirl.create(:question, user: user)
      a1 = FactoryGirl.create(:answer, user: user, question: q)
      a2 = FactoryGirl.create(:answer, user: user, question: q)
      a3 = FactoryGirl.create(:answer, user: user, question: q)

      expect(user.recent_three_answers).to eq([a3,a2,a1])
    end
  end

  context "#karma" do
    it "should return the karma" do
      user = FactoryGirl.create(:user)
      q = FactoryGirl.create(:question, user: user)
      expect(user.karma).to eq(0)
    end
  end
end

