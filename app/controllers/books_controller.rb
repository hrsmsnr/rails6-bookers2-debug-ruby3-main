class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @today = Date.today
    @today_count = @books.where("DATE(created_at) = ?", Date.today).count
    @yesterday_count = @books.where("DATE(created_at) = ?", Date.today - 1.day).count
    # @yesterday_count = @books.where("DATE(created_at) = ?", 1.day.ago).count
    @this_week_count = @books.where(created_at: Date.today - 1.week + 1.day..@today + 1.day).count
    # @this_week_count = @books.where(created_at: 1.week.ago..Time.now).count
    @last_week_count = @books.where(created_at: Date.today - 2.week + 1.day..Date.today - 1.week + 1.day).count
    # @last_week_count = @books.where(created_at: 2.week.ago..1.week.ago).count
    
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  # def is_matching_login_user
  #   user = Book.find(params[:id])
  #   unless user.user_id == current_user.id
  #     redirect_to books_path
  #   end
  # end
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
