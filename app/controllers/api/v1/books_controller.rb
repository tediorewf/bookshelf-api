module Api
  module V1
    class BooksController < ApiBaseController
      def index
        render json: BooksSerializer.new(books).as_json, status: :ok
      end

      def create
        if book.save
          render Api::V1::BookSerializer.new(book).as_json, status: :created
        else
          invalid_resource!(book.errors)
        end
      end

      def show
        render json: BookSerializer.new(book).as_json, status: :ok
      end

      def update
        if book.update(update_book_params)
          render json: BookSerializer.new(book).as_json, status: :created
        else
          invalid_resource!(book.errors)
        end
      end

      def destroy
        book.destroy!

        render status: :no_content
      end

      private

      def default_book_filters
        %i(author title)
      end

      def create_book_params
        params.require(:book).permit(*default_book_filters)
      end

      def update_book_params
        create_book_params
      end

      def load_resource
        case params[:action].to_sym
        when :index
          @books = current_user.books
        when :create
          @book = Book.new(create_book_params.merge(user: current_user))
        when :show, :update, :destroy
          @book = current_user.books.find(params[:id])
        end
      end

      attr_reader :book, :books
    end
  end
end
