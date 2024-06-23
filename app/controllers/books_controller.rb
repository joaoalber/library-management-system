class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize, only: %i[finish_borrow destroy edit update create new]

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

  # actions authorized only by librarian user

  def authorize
    redirect_to users_path, notice: "You are not authorized to perform this action" if current_user.member?
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to users_path, notice: 'Book was successfully created'
    else
      redirect_to users_path, alert: 'There was an error creating the book, please try again'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to users_path, notice: 'Book was successfully updated'
    else
      redirect_to users_path, alert: 'There was an error updating the book, please try again'
    end
  end

  def finish_borrow
    borrowing = Borrowing.find_by(book_id: params[:id])
    
    if borrowing.update(returned_at: DateTime.now)
      redirect_to users_path, notice: "The borrowing was successfully finished"
    else
      redirect_to users_path, notice: "An error occurred while trying to finish the borrowing, please try again"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!

    redirect_to users_path, notice: "Book successfully deleted"
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :isbn)
  end
end
