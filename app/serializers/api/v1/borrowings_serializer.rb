module Api
  module V1
    class BorrowingsSerializer
      def initialize(borrowings)
        @borrowings = borrowings
      end

      def as_json
        borrowings.map do |borrowing|
          BorrowingSerializer.new(borrowing).as_json
        end
      end

      private

      attr_reader :borrowings
    end
  end
end
