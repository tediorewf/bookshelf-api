module Api
  module V1
    class BooksController < ApiController
      include Authenticator

      def index
        books = current_user.books

        render json: BooksRepresenter.new(books).as_json, status: :ok
      end

      def create
        book = Book.new(book_params.merge(user: current_user))

        if book.save
          render BookRepresenter.new(book).as_json, status: :created
        else
          render json: { errors: book.errors }, status: :unprocessable_entity
        end
      end

      def show
        book = current_user.books.find(params[:id])

        render json: BookRepresenter.new(book).as_json, status: :ok
      end

      def update
        book = current_user.books.find(params[:id])

        if book.update(book_params)
          render json: BookRepresenter.new(book).as_json, status: :created
        else
          render json: { errors: book.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        book = current_user.books.find(params[:id])

        if book.destroy
          render status: :no_content
        else
          render json: { errors: book.errors }, status: :bad_request
        end
      end

      private

      def book_params
        params.permit(:author, :title)
      end
    end
  end
end
