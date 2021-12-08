module Api
  module V1
    class UsersController < ApiBaseController
      skip_before_action :authenticate_user!, only: :create

      def create
        if user.save
          render json: UserSerializer.new(user).as_json, status: :created
        else
          invalid_resource!(user.errors)
        end
      end

      private

      def default_user_filters
        %i(email password password_confirmation)
      end

      def create_user_params
        params.require(:user).permit(*default_user_filters)
      end

      def load_resource
        case params[:action].to_sym
        when :create
          @user = User.new(create_user_params)
        end
      end

      attr_reader :user
    end
  end
end
