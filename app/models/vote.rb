class Vote < ActiveRecord::Base
  belongs_to :user
  #polymorphic
  belongs_to :votable, polymorphic: true


end
