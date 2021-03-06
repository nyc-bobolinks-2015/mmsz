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
    Question.all.order(updated_at: :desc)
  end

  def self.greatest
    questions = Question.all
    questions.sort_by{|question| -question.vote_count}
  end

  def calculate_vote
    upvote = self.votes.where(up_vote:true).count
    downvote= self.votes.count - upvote
    net=upvote-downvote
  end
end