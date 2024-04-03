class UsersController < ApplicationController
	before_action :ensure_correct_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
		@books = @user.books
		@book = Book.new
		@following_users = @user.following_users
		@follower_users = @user.follower_users
		@today = Date.today
		@today_count = @books.where("DATE(created_at) = ?", Date.today).count
		@yesterday_count = @books.where("DATE(created_at) = ?", Date.today - 1.day).count
		# @yesterday_count = @books.where("DATE(created_at) = ?", 1.day.ago).count
		@this_week_count = @books.where(created_at: Date.today - 1.week + 1.day..@today + 1.day).count
		# @this_week_count = @books.where(created_at: 1.week.ago..Time.now).count
		@last_week_count = @books.where(created_at: Date.today - 2.week + 1.day..Date.today - 1.week + 1.day).count
		# @last_week_count = @books.where(created_at: 2.week.ago..1.week.ago).count
	end

	def follows
		user = User.find(params[:user_id])
		@users = user.following_users
	end

	def followers
		user = User.find(params[:user_id])
		@users = user.follower_users
	end

	def index
		@users = User.all
		@user = current_user
		@book = Book.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
			redirect_to user_path(@user)
		else
			render :edit
		end
	end
	
	def count_search
		@user = User.find(params[:user_id])
		@count_result = @user.books.looks(params[:select_date])
	end

	private

	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

	def ensure_correct_user
		user = User.find(params[:id])
		unless user.id == current_user.id
			redirect_to user_path(current_user.id)
		end
	end
end