class FavoritesController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		current_user.favorites.create(book_id: book.id)
		# favorite = current_user.favorites.new(book_id: book.id)
		# favorite.save
		# "favorite ="のあたりから 一文でまとめて表すなら
		# current_user.favorites.create(book_id: book.id)
		# さらに分けるなら
		# current_user.favo(params[:book_id])
		# model↓
		# def favo(book_id)
		# favorites.create(book_id, book_id)
		redirect_to request.referer
	end
	def destroy
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
		redirect_to request.referer
	end
end
