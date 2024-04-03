class SearchesController < ApplicationController
	before_action :authenticate_user!
	
	def search
		@kinds = params[:kinds]
		@keyword = params[:keyword]
		
		if @kinds == "User"
			@users = User.looks(params[:accuracy], params[:keyword])
			render "/searches/search_result"
		elsif @kinds == "Book"
			@books = Book.looks(params[:accuracy], params[:keyword])
			render "/searches/search_result"
		else
			redirect_to request.referer
			
		end
	end
	
end
