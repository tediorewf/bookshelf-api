module Api
  module V1
    class TokenController < ApiController
      before_action :load_resource

      def create
        if user&.authenticate(params.require(:password))
          render json: { token: TokenService.encode(sub: user.id) }, status: :created
        else
          message = "User with provided credentials does not exist"
          render json: { errors: message }, status: :bad_request
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :create
          @user = User.find_by_email(params.require(:email))
        end
      end

      attr_reader :user
    end
  end
end
