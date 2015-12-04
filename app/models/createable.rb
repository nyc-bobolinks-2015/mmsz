module Createable
	def created_date
		self.created_at.to_date
	end
	def created_ago
		Date.today - created_date
	end
end