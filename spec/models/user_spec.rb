require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, role: "member") }
  let(:admin) { create(:user, role: "librarian") }

  describe '#librarian?' do
    it 'returns true if the user is a librarian' do
      expect(admin.librarian?).to be_truthy
    end

    it 'returns false if the user is not a librarian' do
      expect(user.librarian?).to be_falsey
    end
  end

  describe '#member?' do
    it 'returns true if the user is a member' do
      expect(user.member?).to be_truthy
    end

    it 'returns false if the user is not a member' do
      expect(admin.member?).to be_falsey
    end
  end

  describe '#borrowed_books' do
    let!(:borrowing1) { create(:borrowing, user: user) }
    let!(:borrowing2) { create(:borrowing, user: user) }

    it 'returns the borrowing information and associated book for the user' do
      expect(user.borrowed_books.size).to eq(2)
      expect(user.borrowed_books.first[:borrowing_information]).to eq(borrowing1)
      expect(user.borrowed_books.first[:book]).to eq(borrowing1.book)
      expect(user.borrowed_books.last[:borrowing_information]).to eq(borrowing2)
      expect(user.borrowed_books.last[:book]).to eq(borrowing2.book)
    end
  end
end