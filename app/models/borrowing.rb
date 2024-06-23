class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  before_create :set_returnal_date
  validate :user_cannot_borrow_multiple_times

  RETURNAL_DAYS = 14.days

  def overdue?
    return_at.past?
  end

  private

  def set_returnal_date
    self.return_at = Date.today + RETURNAL_DAYS
  end

  def user_cannot_borrow_multiple_times
    if book.borrowed_multiple_times_by?(user)
      errors.add(:borrowed_multiple_times, "user cannot borrow the book more than 3 times")
    end
  end
end
