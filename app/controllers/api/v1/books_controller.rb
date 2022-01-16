module Api
  module V1
    class BooksController < Api::V1::ApiBaseController
      before_action :load_resource

      def index
        render jsonapi: books,
               each_serializer: Api::V1::BookSerializer,
               meta: meta_attributes(books),
               status: :ok
      end

      def create
        if book.save
          render jsonapi: book,
                 serializer: Api::V1::BookSerializer,
                 status: :created
        else
          unprocessable_entity!(book.errors)
        end
      end

      def show
        render jsonapi: book,
               serializer: Api::V1::BookSerializer,
               status: :ok
      end

      def update
        if book.update(update_book_params)
          render jsonapi: book,
                 serializer: Api::V1::BookSerializer,
                 status: :created
        else
          unprocessable_entity!(book.errors)
        end
      end

      def destroy
        if book.destroy
          render status: :no_content
        else
          bad_request!(book.errors)
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :index
          @books = paginate(current_user.books)
        when :create
          @book = current_user.books.new(create_book_params)
        when :show, :update, :destroy
          @book = current_user.books.find(params[:id])
        end
      end

      def update_book_params
        create_book_params
      end

      def create_book_params
        params.require(:book).permit(*default_book_filters)
      end

      def default_book_filters
        %i(author title)
      end

      attr_reader :book, :books
    end
  end
end
