module Api
  module V1
    class BorrowingsController < ApiBaseController
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
          invalid_resource!(borrowing.errors)
        end
      end

      def show
        render jsonapi: borrowing,
               serializer: Api::V1::BorrowingSerializer,
               status: :ok
      end

      def update
        if borrowing.update(update_borrowing_params)
          render jsonapi: borrowing,
                 serializer: Api::V1::BorrowingSerializer,
                 status: :created
        else
          invalid_resource!(borrowing.errors)
        end
      end

      def destroy
        if borrowing.destroy
          render status: :no_content
        else
          bad_request!(borrowing.errors)
        end
      end

      private

      def default_borrowing_filters
        %i(book_id reader_id)
      end

      def create_borrowing_params
        params.require(:borrowing).permit(*default_borrowing_filters)
      end

      def update_borrowing_params
        create_borrowing_params
      end

      def load_resource
        case params[:action].to_sym
        when :index
          @borrowings = paginate(current_user.borrowings)
        when :create
          @borrowing = Borrowing.new(create_borrowing_params.merge(user: current_user))
        when :show, :update, :destroy
          @borrowing = current_user.borrowings.find(params[:id])
        end
      end

      attr_reader :borrowing, :borrowings
    end
  end
end
