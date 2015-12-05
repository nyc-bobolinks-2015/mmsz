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
end