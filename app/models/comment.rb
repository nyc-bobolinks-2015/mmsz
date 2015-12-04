class Comment < ActiveRecord::Base
	include createable
	
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
