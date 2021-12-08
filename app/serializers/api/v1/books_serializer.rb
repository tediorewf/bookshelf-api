module Api
  module V1
    class BooksSerializer
      def initialize(books)
        @books = books
      end

      def as_json
        books.map do |book|
          BookSerializer.new(book).as_json
        end
      end

      private

      attr_reader :books
    end
  end
end
