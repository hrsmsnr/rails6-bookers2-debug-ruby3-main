class Book < ApplicationRecord

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(accuracy, keyword)
    if accuracy == "perfect_match"
      @book = Book.where("title LIKE?", "#{keyword}")
    elsif accuracy == "forward_match"
      @book = Book.where("title LIKE?", "#{keyword}%")
    elsif accuracy == "backward_match"
      @book = Book.where("title LIKE?", "%#{keyword}")
    elsif accuracy == "partial_match"
      @book = Book.where("title LIKE?", "%#{keyword}%")
    else
      @book = Book.all
    end
  end

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
end
