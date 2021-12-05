module Api
  module V1
    class TokenController < ApiController
      def create
        user = User.find_by_email!(params.require(:email))

        if user.authenticate(params.require(:password))
          render json: { token: TokenService.encode(sub: user.id) }, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
