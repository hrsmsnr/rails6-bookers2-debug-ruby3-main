class BookCommentsController < ApplicationController

	def create
		@book = Book.find(params[:book_id])
		comment = current_user.book_comments.new(book_comment_params)
		# comment = BookComment.new(book_comment_params)
		# comment.user_id = current_user.id
		# 上の二つの記述をしたのと同じ
		comment.book_id = @book.id
		comment.save
	end

	def destroy
		@book = Book.find(params[:book_id])
		comment = BookComment.find(params[:id])
		comment.destroy
		# BookComment.find(params[:id]).destroy
		# redirect_to book_path(params[:book_id])
	end

	private

	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end

end
