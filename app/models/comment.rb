class Comment < ActiveRecord::Base
	include Createable

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
