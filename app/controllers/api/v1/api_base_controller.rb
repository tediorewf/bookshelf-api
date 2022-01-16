module Api
  module V1
    class ApiBaseController < ApplicationController
      include ActionController::HttpAuthentication::Token
      include CustomErrors
      include PaginationParamsParser

      before_action :authenticate_user!

      rescue_from ActionController::ParameterMissing do
        api_error(status: 400, errors: 'Invalid parameters')
      end

      rescue_from ActiveRecord::RecordNotFound do
        api_error(status: 404, errors: 'Resource not found')
      end

      rescue_from UnauthenticatedError do
        unauthenticated!
      end

      protected

      def authenticate_user!
        authenticate_user or raise UnauthenticatedError
      end

      def authenticate_user
        token, _ = token_and_options(request)
        return nil unless token

        decoded_token = TokenService.decode(token)
        return nil unless decoded_token

        user_id = decoded_token['sub']
        return nil unless user_id

        user = User.find_by(id: user_id)
        if user
          @current_user = user
        else
          nil
        end
      end

      def paginate(resource)
        page = parse_page(params[:page])
        per_page = parse_per_page(params[:per_page])
        resource.paginate(page: page, per_page: per_page)
      end

      # ATTENTION: expects paginated resource!
      def meta_attributes(resource, extra_meta = {})
        {
          current_page: resource.current_page,
          next_page: resource.next_page,
          prev_page: resource.previous_page,
          total_pages: resource.total_pages,
          total_count: resource.total_entries
        }.merge(extra_meta)
      end

      def bad_request!(errors = [])
        api_error(status: 400, errors: errors)
      end

      def unauthenticated!
        api_error(status: 401, errors: 'Not Authenticated')
      end

      def not_found!
        api_error(status: 404, errors: 'Resource not found')
      end

      def unprocessable_entity!(errors = [])
        api_error(status: 422, errors: errors)
      end

      def api_error(status: 500, errors: [])
        render json: ErrorSerializer.new(status, errors).as_json,
               status: status
      end

      attr_reader :current_user
    end
  end
end
