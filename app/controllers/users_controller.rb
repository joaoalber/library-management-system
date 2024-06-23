class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.librarian?
      render :librarian_dashboard
    else
      @borrowed_books = current_user.borrowed_books
      render :member_dashboard
    end
  end
end
