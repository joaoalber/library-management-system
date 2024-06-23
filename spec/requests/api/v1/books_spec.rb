require 'rails_helper'

RSpec.describe API::V1::Books, type: :request do
  let(:json) { JSON.parse(last_response.body) }

  describe 'POST /api/v1/books' do
    let(:valid_attributes) { attributes_for(:book) }

    context 'when the request is valid' do
      it 'creates a book' do
        expect {
          post '/api/v1/books', valid_attributes
        }.to change(Book, :count).by(1)

        expect(last_response.status).to eq(201)
        expect(json['title']).to eq(valid_attributes[:title])
      end
    end

    context 'when the request is invalid' do
      it 'returns a validation failure message' do
        post '/api/v1/books', {}

        expect(last_response.status).to eq(400)
        expect(json['error']).to match(/title is missing/)
      end
    end
  end

  describe 'PATCH /api/v1/books' do
    let!(:book) { create(:book) }
    let(:valid_attributes) { { id: book.id, title: 'New Title' } }

    context 'when the book exists' do
      it 'updates the book' do
        patch '/api/v1/books', valid_attributes
        expect(last_response.status).to eq(200)
        expect(book.reload.title).to eq('New Title')
      end
    end

    context 'when the book does not exist' do
      it 'returns a not found message' do
        patch '/api/v1/books', { id: 0, title: 'New Title' }
  
        expect(last_response.status).to eq(404)
      end
    end
  end

  describe 'DELETE /api/v1/books' do
    let!(:book) { create(:book) }

    it 'deletes the book' do
      expect {
        delete '/api/v1/books', { id: book.id }
      }.to change(Book, :count).by(-1)

      expect(last_response.status).to eq(200)
    end

    context 'when the book does not exist' do
      it 'returns an invalid id message' do
        delete '/api/v1/books', { id: SecureRandom.uuid }

        expect(last_response.status).to eq(400)
        expect(json["error"]).to eq("id is invalid")
      end
    end
  end

  describe 'GET /api/v1/books' do
    let!(:books) { create_list(:book, 10) }

    it 'returns all books' do
      get '/api/v1/books'

      expect(last_response.status).to eq(200)
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /api/v1/books/:id' do
    let!(:book) { create(:book) }

    context 'when the book exists' do
      it 'returns the book' do
        get "/api/v1/books/#{book.id}"

        expect(last_response.status).to eq(200)
        expect(json['title']).to eq(book.title)
      end
    end

    context 'when the book does not exist' do
      it 'returns a not found status' do
        get "/api/v1/books/#{SecureRandom.uuid}"

        expect(last_response.status).to eq(404)
      end
    end
  end
end