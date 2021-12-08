module Api
  module V1
    class ReadersController < ApiBaseController
      def index
        render json: ReadersSerializer.new(readers).as_json, status: :ok
      end

      def create
        if reader.save
          render json: ReaderSerializer.new(reader).as_json, status: :created
        else
          invalid_resource!(reader.errors)
        end
      end

      def show
        render json: ReaderSerializer.new(reader).as_json, status: :ok
      end

      def update
        if reader.update(update_reader_params)
          render json: ReaderSerializer.new(reader).as_json, status: :created
        else
          invalid_resource!(reader.errors)
        end
      end

      def destroy
        reader.destroy!

        render status: :no_content
      end

      private

      def default_reader_filters
        %i(email first_name last_name phone)
      end

      def create_reader_params
        params.require(:reader).permit(*default_reader_filters)
      end

      def update_reader_params
        create_reader_params
      end

      def load_resource
        case params[:action].to_sym
        when :index
          @readers = current_user.readers
        when :create
          @reader = Reader.new(create_reader_params.merge(user: current_user))
        when :show, :update, :destroy
          @reader = current_user.readers.find(params[:id])
        end
      end

      attr_reader :reader, :readers
    end
  end
end
