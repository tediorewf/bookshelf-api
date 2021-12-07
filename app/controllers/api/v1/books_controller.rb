module Api
  module V1
    class BooksController < ApiController
      include Authenticator

      before_action :load_resource

      def index
        render json: BooksRepresenter.new(books).as_json, status: :ok
      end

      def create
        if book.save
          render BookRepresenter.new(book).as_json, status: :created
        else
          render json: { errors: book.errors }, status: :unprocessable_entity
        end
      end

      def show
        render json: BookRepresenter.new(book).as_json, status: :ok
      end

      def update
        if book.update(book_params)
          render json: BookRepresenter.new(book).as_json, status: :created
        else
          render json: { errors: book.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if book.destroy
          render status: :no_content
        else
          render json: { errors: book.errors }, status: :bad_request
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :index
          @books = current_user.books
        when :create
          @book = Book.new(book_params.merge(user: current_user))
        when :show, :update, :destroy
          @book = current_user.books.find(params[:id])
        end
      end

      def book_params
        params.permit(:author, :title)
      end

      attr_reader :book, :books
    end
  end
end
