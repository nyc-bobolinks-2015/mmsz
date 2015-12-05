class Comment < ActiveRecord::Base
	include Createable

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true
  validates :body, length: {in: 1..3000}
end
