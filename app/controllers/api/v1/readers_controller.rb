module Api
  module V1
    class ReadersController < ApiController
      include Authenticator

      before_action :load_resource

      def index
        render json: ReadersRepresenter.new(readers).as_json, status: :ok
      end

      def create
        if reader.save
          render json: ReaderRepresenter.new(reader).as_json, status: :created
        else
          render json: { errors: reader.errors }, status: :unprocessable_entity
        end
      end

      def show
        render json: ReaderRepresenter.new(reader).as_json, status: :ok
      end

      def update
        if reader.update(reader_params)
          render json: ReaderRepresenter.new(reader).as_json, status: :created
        else
          render json: { errors: reader.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if reader.destroy
          render status: :no_content
        else
          render json: { errors: reader.errors }, status: :bad_request
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :index
          @readers = current_user.readers
        when :create
          @reader = Reader.new(reader_params.merge(user: current_user))
        when :show, :update, :destroy
          @reader = current_user.readers.find(params[:id])
        end
      end

      def reader_params
        params.permit(:first_name, :last_name, :phone, :email)
      end

      attr_reader :reader, :readers
    end
  end
end
