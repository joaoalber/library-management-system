class BorrowingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :book_id, :return_at
end
