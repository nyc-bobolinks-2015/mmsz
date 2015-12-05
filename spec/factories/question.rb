FactoryGirl.define do
  factory(:question) do
    title Faker::Commerce.product_name
    body Faker::Lorem.paragraph
    association :user, factory: :user
  end
end
