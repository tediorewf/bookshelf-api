module Api
  module V1
    class TokenController < ApplicationController
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      def create
        user = User.find_by(email: params.require(:email))

        if user&.authenticate(params.require(:password))
          render json: { token: TokenHelper.encode(sub: user.id) }, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def parameter_missing(e)
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end
end
