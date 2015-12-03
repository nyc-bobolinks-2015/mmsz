class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :votes
  has_many :comments

  validates :username, presence: true
  validates :username, length: {in: 1..40}


end
