class Question < ActiveRecord::Base
	include Createable
	include VoteCounter

  has_many :answers, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  belongs_to :user
  has_and_belongs_to_many :tags


  validates :title, :body, presence:true
  validates :title, length: {in: 1..400}
  validates :body, length: {in: 1..3000}

  def self.added_today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def self.added_this_week
    where("created_at >= ?", Time.zone.now.beginning_of_day - 7.days)
  end

  def self.latest
    #You don't need the all here
    Question.order(updated_at: :desc)
  end

  #Maybe call this most_voted or highest_voted
  def self.greatest
    # Question.joins(:votes).group('questions.id').order('sum(case when votes.up_vote then 1 else -1 end) desc').limit(10)
    questions = Question.all
    questions.sort_by{|question| -question.vote_count}
  end

  # You can do this in one sql statement
  # Vote.where(votable: self).sum('case when up_vote then 1 else -1 end')
  def calculate_vote
    upvote = self.votes.where(up_vote:true).count
    downvote= self.votes.count - upvote
    net=upvote-downvote
  end
end