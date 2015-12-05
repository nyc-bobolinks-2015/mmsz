FactoryGirl.define do
  factory(:answer) do
    body Faker::Lorem.paragraph
    association :user, factory: :user
    association :question, factory: :question
  end
end
