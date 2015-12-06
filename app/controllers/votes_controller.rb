class VotesController < ApplicationController
	def create
		if (params[:question_id])
			question = Question.find(params[:question_id])
			existing_record = question.votes.where(user_id:current_user.id)
			if existing_record.length != 0
				@votes = question.calculate_vote
			else
				vote = question.votes.create(up_vote:params[:upvote],user_id:current_user.id)
				@votes = question.calculate_vote
			end
			render partial:"vote_count",locals:{count: @votes}
		else
			answer = Answer.find(params[:answer_id])
			existing_record = answer.votes.where(user_id:current_user.id)
			if existing_record.length != 0
				@votes = answer.calculate_vote
			else
				vote = answer.votes.create(up_vote:params[:upvote],user_id:current_user.id)
				@votes = answer.calculate_vote
			end
			render partial:"answer_vote_count",locals:{count: @votes,answer_id:answer.id}
		end
	end

	def vote_params
		params.require(:vote).permit(:up_vote).merge(user_id: current_user.id)
	end
end