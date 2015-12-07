module VoteCounter
	def vote_count
		self.votes.where(up_vote: true).count - self.votes.where(up_vote: false).count
	end
end
