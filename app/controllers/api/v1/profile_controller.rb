module Api
  module V1
    class ProfileController < ApiController
      include Authenticator

      def show
        render json: { email: current_user.email }, status: :ok
      end
    end
  end
end
