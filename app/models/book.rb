class Book < ApplicationRecord
  has_many :borrowings

  scope :search, -> (term) {
    sanitized_term = sanitize_sql_like(term)
    where('title LIKE :term OR author LIKE :term OR genre LIKE :term', term: "%#{sanitized_term}%")
  }

  def borrowed_multiple_times_by?(user)
    borrowings.where(user_id: user.id).count >= 3
  end

  def available?
    borrowings.all?(&:returned_at)
  end
end
