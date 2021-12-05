module Api
  module V1
    class ReadersController < ApiController
      include Authenticator

      def index
        readers = current_user.readers

        render json: ReadersRepresenter.new(readers).as_json, status: :ok
      end

      def create
        reader = Reader.new(reader_params.merge(user: current_user))

        if reader.save
          render json: ReaderRepresenter.new(reader).as_json, status: :created
        else
          render json: { errors: reader.errors }, status: :unprocessable_entity
        end
      end

      def show
        reader = current_user.readers.find(params[:id])

        render json: ReaderRepresenter.new(reader).as_json, status: :ok
      end

      def update
        reader = current_user.readers.find(params[:id])

        if reader.update(reader_params)
          render json: ReaderRepresenter.new(reader).as_json, status: :created
        else
          render json: { errors: reader.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        reader = current_user.readers.find(params[:id])

        if reader.destroy
          render status: :no_content
        else
          render json: { errors: reader.errors }, status: :bad_request
        end
      end

      private

      def reader_params
        params.permit(:first_name, :last_name, :phone, :email)
      end
    end
  end
end
