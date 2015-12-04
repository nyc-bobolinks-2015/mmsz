class Answer < ActiveRecord::Base
	include Createable
	include VoteCounter

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :question
  belongs_to :user
end
