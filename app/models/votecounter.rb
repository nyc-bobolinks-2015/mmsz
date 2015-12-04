module VoteCounter
	def vote_count
		self.votes.where(upvote: true).count - self.votes.where(upvote: false).count
	end
end