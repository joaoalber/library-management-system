module API
  module V1
    class Base < Grape::API
      mount API::V1::Books
      mount API::V1::Borrowings
    end
  end
end
