module Api
  module V1
    class ProfileController < ApiController
      include Authenticator

      def show
        render json: ProfileRepresenter.new(current_user).as_json, status: :ok
      end
    end
  end
end
