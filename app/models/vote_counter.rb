#You might want to make this a concern
module VoteCounter
  #You could do this with one query
	def vote_count
		self.votes.where(up_vote: true).count - self.votes.where(up_vote: false).count
	end
end
