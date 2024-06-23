require 'rails_helper'

RSpec.describe API::V1::Borrowings, type: :request do
  let(:json) { JSON.parse(last_response.body) }

  describe 'POST /api/v1/borrowings' do
    let!(:borrowing) { create(:borrowing) }
    let(:valid_attributes) { { user_id: borrowing.user_id, book_id: borrowing.book_id } }

    context 'when the request is valid' do
      it 'creates a borrowing' do
        expect {
          post '/api/v1/borrowings', valid_attributes
        }.to change(Borrowing, :count).by(1)

        expect(last_response.status).to eq(201)
        expect(Borrowing.count).to eq(2)
        expect(json['user_id']).to eq(valid_attributes[:user_id])
        expect(json['book_id']).to eq(valid_attributes[:book_id])
      end
    end

    context 'when the request is invalid' do
      it 'returns a validation failure message' do
        post '/api/v1/borrowings', {}

        expect(last_response.status).to eq(400)
        expect(json['error']).to match(/user_id is missing, book_id is missing/)
      end
    end
  end

  describe 'PATCH /api/v1/borrowings' do
    let!(:borrowing) { create(:borrowing) }
    let(:valid_attributes) { { id: borrowing.id, return_at: Time.now + 1.day } }

    context 'when the borrowing exists' do
      it 'updates the borrowing' do
        patch '/api/v1/borrowings', valid_attributes

        expect(last_response.status).to eq(200)
        expect(borrowing.reload.return_at.to_i).to eq(valid_attributes[:return_at].to_i)
      end
    end

    context 'when the borrowing does not exist' do
      it 'returns a not found message' do
        patch '/api/v1/borrowings', { id: 0, return_at: Time.now + 1.day }

        expect(last_response.status).to eq(404)
      end
    end
  end

  describe 'DELETE /api/v1/borrowings' do
    let!(:borrowing) { create(:borrowing) }

    it 'deletes the borrowing' do
      expect {
        delete "/api/v1/borrowings", { id: borrowing.id }
      }.to change(Borrowing, :count).by(-1)

      expect(last_response.status).to eq(200)
    end

    context 'when the borrowing does not exist' do
      it 'returns a not valid id message' do
        delete "/api/v1/borrowings", { id: SecureRandom.uuid }

        expect(last_response.status).to eq(400)
        expect(json["error"]).to eq("id is invalid")
      end
    end
  end

  describe 'GET /api/v1/borrowings' do
    let!(:borrowings) { create_list(:borrowing, 10) }

    it 'returns all borrowings' do
      get '/api/v1/borrowings'

      expect(last_response.status).to eq(200)
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /api/v1/borrowings/:id' do
    let!(:borrowing) { create(:borrowing) }

    context 'when the borrowing exists' do
      it 'returns the borrowing' do
        get "/api/v1/borrowings/#{borrowing.id}"

        expect(last_response.status).to eq(200)
        expect(json['user_id']).to eq(borrowing.user_id)
        expect(json['book_id']).to eq(borrowing.book_id)
      end
    end

    context 'when the borrowing does not exist' do
      it 'returns a not found status' do
        get "/api/v1/borrowings/#{SecureRandom.uuid}"

        expect(last_response.status).to eq(404)
      end
    end
  end
end