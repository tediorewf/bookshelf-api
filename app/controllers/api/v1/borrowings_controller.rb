module Api
  module V1
    class BorrowingsController < ApiController
      include Authenticator

      def index
        borrowings = current_user.borrowings

        render json: BorrowingsRepresenter.new(borrowings).as_json, status: :ok
      end

      def create
        borrowing = Borrowing.new(borrowing_params.merge(user: current_user))

        if borrowing.save
          render BorrowingRepresenter.new(borrowing).as_json, status: :created
        else
          render json: { errors: borrowing.errors }, status: :unprocessable_entity
        end
      end

      def show
        borrowing = current_user.borrowings.find(params[:id])

        render json: BorrowingRepresenter.new(borrowing).as_json, status: :ok
      end

      def update
        borrowing = current_user.borrowings.find(params[:id])

        if borrowing.update(borrowing_params)
          render json: BorrowingRepresenter.new(reader).as_json, status: :created
        else
          render json: { errors: borrowing.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        borrowing = current_user.borrowings.find(params[:id])

        if borrowing.destroy
          render status: :no_content
        else
          render json: { errors: borrowing.errors }, status: :bad_request
        end
      end

      private

      def borrowing_params
        params.permit(:reader_id, :book_id)
      end
    end
  end
end
