module Api
  module V1
    class BorrowingsRepresenter
      def initialize(borrowings)
        @borrowings = borrowings
      end

      def as_json
        borrowings.map do |borrowing|
          BorrowingRepresenter.new(borrowing).as_json
        end
      end

      private

      attr_reader :borrowings
    end
  end
end
