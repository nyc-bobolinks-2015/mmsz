class Vote < ActiveRecord::Base
  belongs_to :user
  #polymorphic
  belongs_to :votable, polymorphic: true
#Don't leave blank lines for no reason

end
