module Api
  module V1
    class TokenController < ApiBaseController
      skip_before_action :authenticate_user!, only: :create

      def create
        if user.authenticate(create_token_params[:password])
          render jsonapi: user,
                 serializer: Api::V1::TokenSerializer,
                 status: :created
        else
          invalid_resource!('User with provided credentials does not exist')
        end
      end

      private

      def load_resource
        case params[:action].to_sym
        when :create
          @user = User.find_by_email!(create_token_params[:email])
        end
      end

      def default_token_filters
        %i(email password)
      end

      def create_token_params
        params.require(:user).permit(*default_token_filters)
      end

      attr_reader :user
    end
  end
end
