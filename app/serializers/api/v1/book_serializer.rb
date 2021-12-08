module Api
  module V1
    class BookSerializer
      def initialize(book)
        @book = book
      end

      def as_json
        {
          id: book.id,
          author: book.author,
          title: book.title
        }
      end

      private

      attr_reader :book
    end
  end
end
