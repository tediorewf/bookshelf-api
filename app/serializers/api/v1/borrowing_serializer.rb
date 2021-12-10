module Api
  module V1
    class BorrowingSerializer < Api::V1::ApiBaseSerializer
      attributes :book, :reader

      def book
        Api::V1::BookSerializer.new(object.book)
      end

      def reader
        Api::V1::ReaderSerializer.new(object.reader)
      end
    end
  end
end
