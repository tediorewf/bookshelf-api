class ApiController < ApplicationController
  include ActionController::HttpAuthentication::Token

  rescue_from JWT::DecodeError, ActiveRecord::RecordNotFound, with: :authentication_failed

  private

  def authenticate_user!
    token, _ = token_and_options(request)
    decoded_token = TokenHelper.decode(token)
    user_id = decoded_token['sub']
    @current_user = User.find(user_id)
  end

  def authentication_failed(e)
    render json: { errors: e.message }, status: :bad_request
  end

  attr_reader :current_user
end
