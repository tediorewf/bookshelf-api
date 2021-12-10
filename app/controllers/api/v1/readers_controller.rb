module Api
  module V1
    class ReadersController < Api::V1::ApiBaseController
      def index
        render jsonapi: readers,
               each_serializer: Api::V1::ReaderSerializer,
               meta: meta_attributes(readers),
               status: :ok
      end

      def create
        if reader.save
          render jsonapi: reader,
                 serializer: Api::V1::ReaderSerializer,
                 status: :created
        else
          unprocessable_entity!(reader.errors)
        end
      end

      def show
        render jsonapi: reader,
               serializer: Api::V1::ReaderSerializer,
               status: :ok
      end

      def update
        if reader.update(update_reader_params)
          render jsonapi: reader,
                 serializer: Api::V1::ReaderSerializer,
                 status: :created
        else
          unprocessable_entity!(reader.errors)
        end
      end

      def destroy
        if reader.destroy
          render status: :no_content
        else
          bad_request!(reader.errors)
        end
      end

      protected

      def load_resource
        case params[:action].to_sym
        when :index
          @readers = paginate(current_user.readers)
        when :create
          @reader = current_user.readers.new(create_reader_params)
        when :show, :update, :destroy
          @reader = current_user.readers.find(params[:id])
        end
      end

      private

      def update_reader_params
        create_reader_params
      end

      def create_reader_params
        params.require(:reader).permit(*default_reader_filters)
      end

      def default_reader_filters
        %i(email name phone)
      end

      attr_reader :reader, :readers
    end
  end
end
