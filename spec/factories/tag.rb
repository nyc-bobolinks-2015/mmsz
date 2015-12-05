FactoryGirl.define do
  factory :tag do
    questions {[FactoryGirl.create(:question)]}
    name { Faker::Name.first_name }
    # association :question, factory: :question
  end
end