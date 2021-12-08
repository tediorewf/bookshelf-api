module Api
  module V1
    class ProfileController < ApiBaseController
      def show
        render json: ProfileSerializer.new(profile).as_json, status: :ok
      end

      private

      def load_resource
        case params[:action].to_sym
        when :show
          @profile = current_user
        end
      end

      attr_reader :profile
    end
  end
end
