module Api
  module V1
    class UsersController < ApiController
      before_action :load_resource

      def create
        if user.save
          render json: UserRepresenter.new(user).as_json, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :create
          @user = User.new(user_params)
        end
      end

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end

      attr_reader :user
    end
  end
end
