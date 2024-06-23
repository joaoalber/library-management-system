module API
  module V1
    class Borrowings < Base
      include API::V1::Defaults

      resource :borrowings do
        desc "Create a borrowing with the given params"
        params do
          requires :user_id, type: Integer, desc: "User that is borrowing"
          requires :book_id, type: Integer, desc: "Book that is being borrowed"
        end

        post "" do
        Borrowing.create!(**permitted_params)
        end

        desc "Update a borrowing with the given params"
        params do
          requires :id, type: Integer, desc: "ID of the borrowing"
          optional :user_id, type: Integer, desc: "User that is borrowing"
          optional :book_id, type: Integer, desc: "Book that is being borrowed"
          optional :return_at, type: DateTime, desc: "Date to user return the book"
        end

        patch "" do
          borrowing = Borrowing.find(permitted_params[:id])
          borrowing.tap { |b| b.update!(**permitted_params.except(:id)) }
        end

        desc "Delete a borrowing with the given id"
        params do
          requires :id, type: Integer, desc: "ID of the borrowing"
        end

        delete "" do
          Borrowing.find(permitted_params[:id]).destroy!
        end

        desc "Return all borrowings"
        get "" do
          Borrowing.all
        end

        desc "Return a borrowing"
        params do
          requires :id, type: Integer, desc: "ID of the borrowing"
        end

        get ":id" do
          Borrowing.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
