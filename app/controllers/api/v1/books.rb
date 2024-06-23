module API
  module V1
    class Books < Base
      include API::V1::Defaults

      resource :books do
        desc "Create a book with given params"
        params do
          requires :title, type: String, desc: "Title of the book"
          requires :author, type: String, desc: "Author of the book"
          requires :genre, type: String, desc: "Genre of the book"
          requires :isbn, type: String, desc: "ISBN of the book"
          optional :total_copies, type: Integer, desc: "Total copies of the book"
        end

        post "" do
          Book.create!(**permitted_params)
        end

        desc "Update a book with the given params"
        params do
          requires :id, type: Integer, desc: "ID of the book"
          optional :title, type: String, desc: "Title of the book"
          optional :author, type: String, desc: "Author of the book"
          optional :genre, type: String, desc: "Genre of the book"
          optional :isbn, type: String, desc: "ISBN of the book"
          optional :total_copies, type: Integer, desc: "Total copies of the book"
        end

        patch "" do
          book = Book.find(permitted_params[:id])
          book.tap { |b| b.update!(**permitted_params.except(:id)) }
        end

        desc "Delete a book with the given id"
        params do
          requires :id, type: Integer, desc: "ID of the book"
        end

        delete "" do
          Book.find(permitted_params[:id]).destroy!
        end

        desc "Return all books"
        get "" do
          Book.all
        end

        desc "Return a book"
        params do
          requires :id, type: Integer, desc: "ID of the borrowing"
        end

        get ":id" do
          Book.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
