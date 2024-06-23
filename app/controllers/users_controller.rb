class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.librarian?
      @books = Book.all.reject(&:available?) if params[:status] == 'borrowed'
      @books = Book.all.select(&:overdue?) if params[:status] == 'overdue'
      @books = Book.all.select(&:due_today?) if params[:status] == 'due_today'
      @books ||= Book.all

      render :librarian_dashboard
    else
      @borrowed_books = current_user.borrowed_books
      render :member_dashboard
    end
  end
end
