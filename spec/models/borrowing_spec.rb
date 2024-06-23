require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  let(:borrowing) { build(:borrowing) }
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'validations' do
    context 'when user tries to borrow the same book multiple times' do
      before do
        3.times { create(:borrowing, user: user, book: book) }
      end

      it 'does not allow the user to borrow the book again' do
        borrowing = build(:borrowing, user: user, book: book)

        expect(borrowing).not_to be_valid
        expect(borrowing.errors[:borrowed_multiple_times]).to include('user cannot borrow the book more than 3 times')
      end
    end
  end

  describe 'set_returnal_date' do
    it 'sets the return_at date before creating the borrowing' do
      borrowing.save

      expect(borrowing.return_at).to eq(Date.today + 14.days)
    end
  end

  describe '#overdue?' do
    context 'when return_at is in the past' do
      let(:borrowing) { create(:borrowing) }

      before { borrowing.update!(return_at: Date.yesterday) }

      it 'returns true' do
        expect(borrowing.overdue?).to be_truthy
      end
    end

    context 'when return_at is in the future' do
      let(:borrowing) { create(:borrowing) }

      before { borrowing.update!(return_at: Date.tomorrow) }

      it 'returns false' do
        expect(borrowing.overdue?).to be_falsey
      end
    end
  end
end
