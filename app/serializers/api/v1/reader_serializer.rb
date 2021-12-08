module Api
  module V1
    class ReaderSerializer
      def initialize(reader)
        @reader = reader
      end

      def as_json
        {
          id: reader.id,
          first_name: reader.first_name,
          last_name: reader.last_name,
          phone: reader.phone,
          email: reader.email
        }
      end

      private

      attr_reader :reader
    end
  end
end
