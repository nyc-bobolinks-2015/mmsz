module Createable
	def created_date
		self.created_at.to_date
	end

  #You could try (Time.now - obj.created_at).to_i / 86400
	def created_ago
		(Date.today - created_date).to_i
	end
  #Also this sort of display-related method is really a view concern
end
