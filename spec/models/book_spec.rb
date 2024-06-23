require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  describe '#search' do
    it 'returns books that match the search term' do
      book1 = create(:book, title: 'Ruby Programming', author: 'Matz', genre: 'Programming')
      book2 = create(:book, title: 'Clean Code', author: 'Robert C. Martin', genre: 'Programming')

      expect(Book.search('Ruby')).to include(book1)
      expect(Book.search('Matz')).to include(book1)
      expect(Book.search('Clean')).to include(book2)
      expect(Book.search('Martin')).to include(book2)
    end
  end

  describe '#borrowed_multiple_times_by?' do
    it 'returns true if the book has been borrowed multiple times by the user' do
      3.times { create(:borrowing, book: book, user: user) }

      expect(book.borrowed_multiple_times_by?(user)).to be_truthy
    end

    it 'returns false if the book has not been borrowed multiple times by the user' do
      create(:borrowing, book: book, user: user)
  
      expect(book.borrowed_multiple_times_by?(user)).to be_falsey
    end
  end

  describe '#available?' do
    it 'returns true if all borrowings are returned' do
      create(:borrowing, book: book, returned_at: Time.current)

      expect(book.available?).to be_truthy
    end

    it 'returns false if any borrowing is not returned' do
      create(:borrowing, book: book, returned_at: nil)

      expect(book.available?).to be_falsey
    end
  end

  describe '#overdue?' do
    it 'returns true if there are overdue borrowings' do
      borrowing = create(:borrowing, book: book, returned_at: nil)
      borrowing.update!(return_at: Date.yesterday)

      expect(book.overdue?).to be_truthy
    end

    it 'returns false if all borrowings are returned or not overdue' do
      borrowing = create(:borrowing, book: book, returned_at: Time.current)
      borrowing.update!(return_at: Date.yesterday)

      expect(book.overdue?).to be_falsey
    end
  end

  describe '#due_today?' do
    it 'returns true if there are borrowings due today' do
      borrowing = create(:borrowing, book: book, returned_at: nil)
      borrowing.update!(return_at: Date.today)

      expect(book.due_today?).to be_truthy
    end

    it 'returns false if there are no borrowings due today' do
      create(:borrowing, book: book, returned_at: nil, return_at: Date.tomorrow)

      expect(book.due_today?).to be_falsey
    end
  end
end
