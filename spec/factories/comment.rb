FactoryGirl.define do
  factory(:question_comment, class: "Comment") do
    body Faker::Lorem.paragraph
    association :commentable, factory: :question
    association :user, factory: :user
  end

  factory(:answer_comment, class: "Comment") do
    body Faker::Lorem.paragraph
    association :commentable, factory: :answer
    association :user, factory: :user
  end
end
