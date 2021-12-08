module Api
  module V1
    class ApiBaseController < ApplicationController
      include Pundit
      include CustomErrors

      before_action :authenticate_user!
      before_action :load_resource

      rescue_from ActionController::ParameterMissing do
        api_error(status: 400, errors: 'Invalid parameters')
      end

      rescue_from ActiveRecord::RecordNotFound do
        api_error(status: 404, errors: 'Resource not found')
      end

      rescue_from Pundit::NotAuthorizedError do
        unauthorized!
      end

      rescue_from UnauthenticatedError do
        unauthenticated!
      end

      protected

      def authenticate_user!
        authenticate_user or raise UnauthenticatedError
      end

      def authenticate_user
        token, _ = ActionController::HttpAuthentication::Token.token_and_options(
          request
        )
        return nil unless token

        decoded_token = TokenService.decode(token)
        return nil unless decoded_token

        user_id = decoded_token['sub']
        return nil unless user_id

        user = User.find_by_id(user_id)
        if user
          @current_user = user
        else
          nil
        end
      end

      def unauthorized!
        unless Rails.env.production? || Rails.env.test?
          Rails.logger.warn { "unauthorized for: #{current_user.try(:id)}" }
        end

        api_error(status: 403, errors: 'Not Authorized')
      end

      def unauthenticated!
        unless Rails.env.production? || Rails.env.test?
          Rails.logger.warn { 'Unauthenticated user has not got access to resource' }
        end

        api_error(status: 401, errors: 'Not Authenticated')
      end

      def not_found!
        Rails.logger.warn { "not_found for: #{current_user.try(:id)}" }

        api_error(status: 404, errors: 'Resource not found')
      end

      def invalid_resource!(errors = [])
        api_error(status: 422, errors: errors)
      end

      def api_error(status: 500, errors: [])
        render json: ErrorSerializer.new(status, errors).as_json,
               status: status
      end

      private

      # HACK
      def load_resource; end

      attr_reader :current_user
    end
  end
end
