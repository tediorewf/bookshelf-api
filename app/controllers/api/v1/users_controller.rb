module Api
  module V1
    class UsersController < Api::V1::ApiBaseController
      skip_before_action :authenticate_user!, only: :create
      before_action :load_resource

      def create
        if user.save
          render jsonapi: user,
                 serializer: Api::V1::UserSerializer,
                 status: :created
        else
          unprocessable_entity!(user.errors)
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :create
          @user = User.new(create_user_params)
        end
      end

      def create_user_params
        params.require(:user).permit(*default_user_filters)
      end

      def default_user_filters
        %i(email password password_confirmation)
      end

      attr_reader :user
    end
  end
end
