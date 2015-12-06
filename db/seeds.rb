# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
30.times {User.create!(username: Faker::Internet.user_name, email: Faker::Internet.email, password: '12345')}
puts "Created Users"

users = User.all
12.times {Question.create!(title: (Faker::Lorem.sentence).gsub(".", "?"), body: Faker::Lorem.paragraphs(1), user_id: users.sample.id)}

questions = Question.all

questions.each do |question|
  12.times {question.answers.create!(body: Faker::Lorem.paragraphs(1), user_id: users.sample.id )}
  5.times {question.comments.create!(body: Faker::Lorem.sentence, user_id: users.sample.id)}
end

answers = Answer.all

answers.each do |answer|
  5.times {answer.comments.create!(body: Faker::Lorem.sentence, user_id: users.sample.id)}
end

30.times {Tag.create!(name: Faker::Name.first_name.downcase)}

tags = Tag.all

100.times do
  question = questions.sample

  question.tags << tags.sample
end

puts "Created Questions_Tags"

1000.times do
  question = questions.sample
  question.votes.create!(user_id: users.sample.id, up_vote: true)
end

100.times do
  question = questions.sample
  question.votes.create!(user_id: users.sample.id, up_vote: false)
end

1000.times do
  answer = answers.sample
  answer.votes.create!(user_id: users.sample.id, up_vote: true)
end

1000.times do
  answer = answers.sample
  answer.votes.create!(user_id: users.sample.id, up_vote: false)
end
