class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :borrowings

  ROLES = %w[librarian member]

  ROLES.each do |role_type|
    define_method("#{role_type}?") { role_type == role }
  end

  def borrowed_books
    borrowings = Borrowing.where(user_id: id)

    borrowings.map do |borrowing|
      {
        borrowing_information: borrowing,
        book: borrowing.book,
      }
    end
  end
end
