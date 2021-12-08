module Api
  module V1
    class ReadersSerializer
      def initialize(readers)
        @readers = readers
      end

      def as_json
        readers.map do |reader|
          ReaderSerializer.new(reader).as_json
        end
      end

      private

      attr_reader :readers
    end
  end
end
