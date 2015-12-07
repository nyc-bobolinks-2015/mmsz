require 'rails_helper'

RSpec.describe Tag, type: :model do
  context "validations" do
    it { should validate_presence_of :name }

    it do
      should validate_length_of(:name).
      is_at_least(1).
      is_at_most(30)
    end
  end

  context "associations" do
    it { should have_and_belong_to_many(:questions) }
  end

  it "should save all fields if tag is valid" do
    tag = Tag.new(name: 'ruby')

    expect {
      tag.save
    }.to change{tag.id}.from(nil).to be_truthy
  end
end
