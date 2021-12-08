module Api
  module V1
    class TokenController < ApiBaseController
      skip_before_action :authenticate_user!, only: :create

      def create
        if user.authenticate(params.require(:password))
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
          @user = User.find_by_email!(params.require(:email))
        end
      end

      attr_reader :user
    end
  end
end
