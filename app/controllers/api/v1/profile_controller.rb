module Api
  module V1
    class ProfileController < ApiBaseController
      def show
        render jsonapi: profile,
               serializer: Api::V1::ProfileSerializer,
               status: :ok
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
