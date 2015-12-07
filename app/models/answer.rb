class Answer < ActiveRecord::Base
	include Createable
	include VoteCounter

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  validates :body, length: {in: 1..3000}

   #This along with the version in Question could be in your voting concern
   def calculate_vote
    upvote = self.votes.where(up_vote:true).count
    downvote= self.votes.count - upvote
    net=upvote-downvote
  end
end
