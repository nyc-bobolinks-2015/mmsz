class Question < ActiveRecord::Base
  has_many :answers

  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  belongs_to :user
  has_and_belongs_to_many :tags


  validates :title, :body, presence:true #!!!
  validates :title, length: {in: 1..400}
  validates :body, length: {in: 1..3000}
end
