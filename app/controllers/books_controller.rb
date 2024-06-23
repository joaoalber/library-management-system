class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all.select(&:available?)
  end

  def search
    @books = Book.search(params[:search]).select(&:available?)
    render :index
  end

  def borrow
    book = Book.find(params[:id])
    borrowing = Borrowing.new(user: current_user, book:)

    if borrowing.save
      redirect_to books_path, notice: "You borrowed the book successfully"
    else
      redirect_to books_path, notice: "Fail while trying to borrow the book, please try again"
    end
  end
end
