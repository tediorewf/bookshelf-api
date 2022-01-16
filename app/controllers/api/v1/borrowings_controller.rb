module Api
  module V1
    class BorrowingsController < Api::V1::ApiBaseController
      before_action :load_resource

      def index
        render jsonapi: borrowings,
               each_serializer: Api::V1::BorrowingSerializer,
               meta: meta_attributes(borrowings),
               status: :ok
      end

      def create
        if borrowing.save
          render jsonapi: borrowing,
                 serializer: Api::V1::BorrowingSerializer,
                 status: :created
        else
          unprocessable_entity!(borrowing.errors)
        end
      end

      def show
        render jsonapi: borrowing,
               serializer: Api::V1::BorrowingSerializer,
               status: :ok
      end

      def destroy
        if borrowing.destroy
          render status: :no_content
        else
          bad_request!(borrowing.errors)
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :index
          @borrowings = paginate(current_user.borrowings)
        when :create
          @borrowing = current_user.borrowings.new(create_borrowing_params)
        when :show, :destroy
          @borrowing = current_user.borrowings.find(params[:id])
        end
      end

      def create_borrowing_params
        params.require(:borrowing).permit(*default_borrowing_filters)
      end

      def default_borrowing_filters
        %i(book_id reader_id)
      end

      attr_reader :borrowing, :borrowings
    end
  end
end
