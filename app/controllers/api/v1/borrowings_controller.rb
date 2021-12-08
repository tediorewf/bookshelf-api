module Api
  module V1
    class BorrowingsController < ApiBaseController
      def index
        render json: BorrowingsSerializer.new(borrowings).as_json, status: :ok
      end

      def create
        if borrowing.save
          render BorrowingSerializer.new(borrowing).as_json, status: :created
        else
          render json: { errors: borrowing.errors }, status: :unprocessable_entity
        end
      end

      def show
        render json: BorrowingSerializer.new(borrowing).as_json, status: :ok
      end

      def update
        if borrowing.update(update_borrowing_params)
          render json: BorrowingSerializer.new(reader).as_json, status: :created
        else
          render json: { errors: borrowing.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        borrowing.destroy!

        render status: :no_content
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
          @borrowings = current_user.borrowings
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
