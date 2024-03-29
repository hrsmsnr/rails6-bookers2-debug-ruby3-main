class RelationshipsController < ApplicationController
	
	def create
		# current_user.relationships.create(followed_id: user_id)
		current_user.follow(params[:user_id])
		redirect_to request.referer
	end
	
	def destroy
		current_user.unfollow(params[:user_id])
		redirect_to request.referer
	end
	
	
	
end
