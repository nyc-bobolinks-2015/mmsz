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
end

