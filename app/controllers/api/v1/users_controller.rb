module Api
  module V1
    class UsersController < ApiController
      def create
        user = User.new(user_params)

        if user.save
          render json: UserRepresenter.new(user).as_json, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
