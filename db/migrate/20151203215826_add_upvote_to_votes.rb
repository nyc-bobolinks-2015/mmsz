class AddUpvoteToVotes < ActiveRecord::Migration
  def change
    add_column :votes,:up_vote, :boolean
  end
end
