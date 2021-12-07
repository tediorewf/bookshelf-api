module Api
  module V1
    class BorrowingsController < ApiController
      include Authenticator

      before_action :load_resource

      def index
        render json: BorrowingsRepresenter.new(borrowings).as_json, status: :ok
      end

      def create
        if borrowing.save
          render BorrowingRepresenter.new(borrowing).as_json, status: :created
        else
          render json: { errors: borrowing.errors }, status: :unprocessable_entity
        end
      end

      def show
        render json: BorrowingRepresenter.new(borrowing).as_json, status: :ok
      end

      def update
        if borrowing.update(borrowing_params)
          render json: BorrowingRepresenter.new(reader).as_json, status: :created
        else
          render json: { errors: borrowing.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if borrowing.destroy
          render status: :no_content
        else
          render json: { errors: borrowing.errors }, status: :bad_request
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :index
          @borrowings = current_user.borrowings
        when :create
          @borrowing = Borrowing.new(borrowing_params.merge(user: current_user))
        when :show, :update, :destroy
          @borrowing = current_user.borrowings.find(params[:id])
        end
      end

      def borrowing_params
        params.permit(:reader_id, :book_id)
      end

      attr_reader :borrowing, :borrowings
    end
  end
end
