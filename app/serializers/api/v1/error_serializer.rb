module Api
  module V1
    class ErrorSerializer
      UNKNOWN_ERROR = 'Something went wrong'.freeze
      private_constant :UNKNOWN_ERROR

      DEFAULT_POINTER = 'data'.freeze
      private_constant :DEFAULT_POINTER

      def initialize(status, errors)
        @status = status
        if errors.is_a?(ActiveModel::Errors)
          @errors = parse_active_model_errors(errors)
        else
          @errors = [errors].flatten
        end
      end

      def as_json
        {
          errors: errors
        }
      end

      private

      def parse_active_model_errors(errors)
        error_messages = errors.full_messages

        errors.map.with_index do |(k, v), i|
          ErrorDecorator.new(k, v, error_messages[i])
        end
      end

      def errors
        @errors.map do |error|
          {
            status: @status,
            title: normalize_title(error),
            detail: normalize_detail(error),
            source: {
              pointer: error_pointer(error)
            }
          }
        end
      end

      def normalize_title(error)
        error.try(:title) || error.try(:to_s) || UNKNOWN_ERROR
      end

      def normalize_detail(error)
        error.try(:detail) || error.try(:to_s) || UNKNOWN_ERROR
      end

      def error_pointer(error)
        if error.respond_to?(:pointer)
          error.pointer
        else
          DEFAULT_POINTER
        end
      end

      class ErrorDecorator
        def initialize(key, value, message)
          @key = key
          @value = value
          @message = message
        end

        def title
          @value
        end

        def detail
          @value
        end

        def to_s
          @message
        end

        def pointer
          "data/attributes/#{@key.to_s}"
        end
      end
    end
  end
end
