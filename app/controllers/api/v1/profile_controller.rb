module Api
  module V1
    class ProfileController < AuthenticateController
      before_action :authenticate_user!

      def show
        render json: { email: current_user.email }, status: :ok
      end
    end
  end
end
